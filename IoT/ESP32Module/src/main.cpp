#include <Arduino.h>
#include <WiFi.h>
#include <esp_now.h>
#include <PubSubClient.h>
#include <TinyGPSPlus.h>

// WiFi & MQTT config
const char* ssid = "admin";
const char* password = "12345678";
const char* mqtt_server = "103.146.22.13";
const int mqtt_port = 1883;

// MQTT topics
const char* topic_data = "coffee_machine/data";
const char* topic_cmd = "coffee_machine/cmd";
const char* topic_image = "coffee_machine/image";

// GPS
HardwareSerial gpsSerial(1); // Use UART1 for GPS
TinyGPSPlus gps;

// Sensor pins (giả sử dùng analog, digital)
#define TEMP_SENSOR_PIN      34
#define PRESSURE_SENSOR_PIN  35
#define CURRENT_SENSOR_PIN   36
#define RELAY_PIN            2 // điều khiển máy pha

// ESP-NOW image chunk struct
#define IMAGE_CHUNK_SIZE 240
typedef struct struct_message {
  uint8_t chunk[IMAGE_CHUNK_SIZE];
  uint16_t chunk_len;
  uint16_t chunk_num;
  uint16_t total_chunks;
} struct_message;

WiFiClient espClient;
PubSubClient client(espClient);

// --- ESP-NOW nhận dữ liệu hình ảnh từ ESP32CAM ---
void OnDataRecv(const uint8_t * mac, const uint8_t *incomingData, int len) {
  struct_message msg;
  memcpy(&msg, incomingData, sizeof(msg));
  // Publish chunk to MQTT
  client.publish(topic_image, (uint8_t*)msg.chunk, msg.chunk_len, false);
  Serial.printf("Image chunk %d/%d (%d bytes) published to MQTT\n", msg.chunk_num, msg.total_chunks, msg.chunk_len);
}

// --- MQTT nhận lệnh điều khiển ---
void callback(char* topic, byte* payload, unsigned int length) {
  String cmd;
  for (unsigned int i = 0; i < length; i++) {
    cmd += (char)payload[i];
  }
  Serial.print("Received command: ");
  Serial.println(cmd);

  if (cmd == "ON") {
    digitalWrite(RELAY_PIN, HIGH); // Bật máy pha
    Serial.println("Coffee machine ON");
  } else if (cmd == "OFF") {
    digitalWrite(RELAY_PIN, LOW); // Tắt máy pha
    Serial.println("Coffee machine OFF");
  } else if (cmd == "RESET") {
    Serial.println("Resetting sensors...");
    // Thực hiện các thao tác reset nếu cần
  }
  // Thêm các lệnh khác nếu cần
}

void setup_wifi() {
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi connected");
  Serial.println(WiFi.localIP());
}

void reconnect_mqtt() {
  while (!client.connected()) {
    Serial.print("Connecting to MQTT...");
    if (client.connect("CoffeeMachineESP32")) {
      Serial.println("MQTT connected");
      client.subscribe(topic_cmd);
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      delay(5000);
    }
  }
}

void setup() {
  Serial.begin(115200);
  gpsSerial.begin(9600, SERIAL_8N1, 16, 17); // RX=16, TX=17 (chỉnh chân cho phù hợp)
  pinMode(RELAY_PIN, OUTPUT);
  digitalWrite(RELAY_PIN, LOW); // Khởi động tắt máy pha

  setup_wifi();
  client.setServer(mqtt_server, mqtt_port);
  client.setCallback(callback);

  // ESP-NOW init
  WiFi.mode(WIFI_STA);
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    return;
  }
  esp_now_register_recv_cb(OnDataRecv);
}

// millis-based non-blocking send
unsigned long lastSendTime = 0;
const unsigned long sendInterval = 1000; // gửi mỗi 1000ms (1 giây)

void loop() {
  if (!client.connected()) {
    reconnect_mqtt();
  }
  client.loop();

  // Đọc dữ liệu GPS liên tục
  while (gpsSerial.available() > 0) {
    gps.encode(gpsSerial.read());
  }

  // Gửi dữ liệu cảm biến và GPS lên MQTT mỗi 1 giây (không dùng delay)
  unsigned long now = millis();
  if (now - lastSendTime >= sendInterval) {
    lastSendTime = now;

    // Đọc cảm biến
    float temp = analogRead(TEMP_SENSOR_PIN) * (3.3 / 4095.0) * 100.0;
    float pressure = analogRead(PRESSURE_SENSOR_PIN) * (3.3 / 4095.0) * 100.0;
    float current = analogRead(CURRENT_SENSOR_PIN) * (3.3 / 4095.0) * 10.0;

    // Tạo chuỗi JSON gửi lên server
    String json = "{";
    json += "\"temp\":" + String(temp, 2) + ",";
    json += "\"pressure\":" + String(pressure, 2) + ",";
    json += "\"current\":" + String(current, 2) + ",";
    if (gps.location.isValid()) {
      json += "\"lat\":" + String(gps.location.lat(), 6) + ",";
      json += "\"lng\":" + String(gps.location.lng(), 6);
    } else {
      json += "\"lat\":0,\"lng\":0";
    }
    json += "}";

    // Publish lên MQTT
    client.publish(topic_data, json.c_str());
    Serial.println(json);
  }
}