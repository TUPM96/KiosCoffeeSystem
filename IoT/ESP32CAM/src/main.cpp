#include <Arduino.h>
#include <WiFi.h>
#include <esp_now.h>
#include "esp_camera.h"

// ESP32-CAM (AI-Thinker module) default pins:
#define PWDN_GPIO_NUM     32
#define RESET_GPIO_NUM    -1
#define XCLK_GPIO_NUM      0
#define SIOD_GPIO_NUM     26
#define SIOC_GPIO_NUM     27

#define Y9_GPIO_NUM       35
#define Y8_GPIO_NUM       34
#define Y7_GPIO_NUM       39
#define Y6_GPIO_NUM       36
#define Y5_GPIO_NUM       21
#define Y4_GPIO_NUM       19
#define Y3_GPIO_NUM       18
#define Y2_GPIO_NUM        5
#define VSYNC_GPIO_NUM    25
#define HREF_GPIO_NUM     23
#define PCLK_GPIO_NUM     22

#define IMAGE_CHUNK_SIZE  240 

// Địa chỉ MAC của ESP32 nhận
uint8_t receiverAddress[] = {0x24, 0x6F, 0x28, 0xAA, 0xBB, 0xCC}; 

// Cấu trúc dữ liệu chunk gửi đi
typedef struct struct_message {
  uint8_t chunk[IMAGE_CHUNK_SIZE];
  uint16_t chunk_len;
  uint16_t chunk_num;
  uint16_t total_chunks;
} struct_message;

// Hàm khởi tạo camera
void setupCamera() {
  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sccb_sda = SIOD_GPIO_NUM;
  config.pin_sccb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;
  // Frame size nhỏ để dễ gửi qua ESP-NOW (ví dụ QQVGA)
  config.frame_size = FRAMESIZE_QQVGA;
  config.jpeg_quality = 12;
  config.fb_count = 1;
  
  // Khởi tạo camera
  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    ESP.restart();
  }
}

// ESP-NOW callback gửi xong
void OnDataSent(const uint8_t *mac_addr, esp_now_send_status_t status) {
  Serial.print("Send Status: ");
  Serial.println(status == ESP_NOW_SEND_SUCCESS ? "Success" : "Fail");
}

void setup() {
  Serial.begin(115200);

  setupCamera();

  WiFi.mode(WIFI_STA);

  // Khởi tạo ESP-NOW
  if (esp_now_init() != ESP_OK) {
    Serial.println("Error initializing ESP-NOW");
    ESP.restart();
  }
  esp_now_register_send_cb(OnDataSent);

  // Ghép địa chỉ MAC của ESP nhận
  esp_now_peer_info_t peerInfo;
  memcpy(peerInfo.peer_addr, receiverAddress, 6);
  peerInfo.channel = 0;  
  peerInfo.encrypt = false;
  if (esp_now_add_peer(&peerInfo) != ESP_OK) {
    Serial.println("Failed to add peer");
    ESP.restart();
  }
}

void loop() {
  // Chụp hình
  camera_fb_t *fb = esp_camera_fb_get();
  if (!fb) {
    Serial.println("Camera capture failed");
    delay(1000);
    return;
  }

  // Chia nhỏ ảnh thành các chunk và gửi lần lượt
  size_t image_size = fb->len;
  uint8_t *image_data = fb->buf;
  uint16_t total_chunks = (image_size + IMAGE_CHUNK_SIZE - 1) / IMAGE_CHUNK_SIZE;

  for(uint16_t chunk_num = 0; chunk_num < total_chunks; chunk_num++) {
    struct_message msg;
    size_t offset = chunk_num * IMAGE_CHUNK_SIZE;
    size_t remaining = image_size - offset;
    msg.chunk_len = remaining > IMAGE_CHUNK_SIZE ? IMAGE_CHUNK_SIZE : remaining;
    memcpy(msg.chunk, image_data + offset, msg.chunk_len);
    msg.chunk_num = chunk_num + 1;
    msg.total_chunks = total_chunks;

    esp_err_t result = esp_now_send(receiverAddress, (uint8_t*)&msg, sizeof(msg));
    if (result == ESP_OK) {
      Serial.printf("Chunk %d/%d sent (%d bytes)\n", msg.chunk_num, msg.total_chunks, msg.chunk_len);
    } else {
      Serial.println("Send Error");
    }
    delay(10); 
  }

  esp_camera_fb_return(fb);

  delay(5000);
}