# Hướng dẫn sử dụng hệ thống KiosCoffeeSystem

---

## 1. Hệ thống IoT

### 1.1. ESP32 Dev Module

- Nạp code vào ESP32 với thông tin WiFi và MQTT broker.
- Kết nối các chân GPIO tới thiết bị cần điều khiển (máy pha cà phê, bơm nước, đèn...).
- Khi khởi động, ESP32 sẽ tự động publish trạng thái và nhận lệnh từ server/app qua MQTT.

#### Cấu hình cần sửa:
```cpp
const char* ssid = "Tên_WiFi";
const char* password = "Mật_khẩu_WiFi";
const char* mqtt_server = "Địa_chỉ_IP_Broker";
```

### 1.2. ESP32-CAM

- Nạp code vào ESP32-CAM với thông tin WiFi và MQTT broker như trên.
- Đảm bảo camera hoạt động, truyền ảnh về server/app qua MQTT hoặc HTTP endpoint đã cấu hình.
- Camera dùng để quan sát/quản lý khu vực pha chế.

#### Cấu hình cần sửa:
```cpp
const char* ssid = "Tên_WiFi";
const char* password = "Mật_khẩu_WiFi";
const char* mqtt_server = "Địa_chỉ_IP_Broker";
```

### 1.3. Đăng ký & kiểm tra thiết bị

- Khi thiết bị IoT kết nối thành công, trạng thái sẽ hiển thị "online" ở app khách hoặc bảng điều khiển admin.

---

## 2. Ứng dụng Flutter (Người dùng)

### 2.1. Cài đặt & chạy app

- Clone source code app Flutter về máy.
- Cài đặt Flutter SDK: [Flutter install guide](https://docs.flutter.dev/get-started/install)
- Tại thư mục dự án, chạy:
  ```bash
  flutter pub get
  flutter run
  ```
- Trên app, nhập thông tin MQTT broker/server nếu được yêu cầu.

### 2.2. Đặt món & theo dõi đơn hàng

- Người dùng chọn món, thêm vào giỏ hàng -> nhấn "Đặt món".
- Trạng thái đơn hàng sẽ cập nhật liên tục trên app.
- Có thể theo dõi trạng thái thiết bị (máy pha cà phê, camera) nếu có.

---

## 3. Ứng dụng NextJS (Admin)

### 3.1. Cài đặt & chạy dashboard admin

- Clone source code NextJS về máy.
- Cài đặt Node.js và npm: [Node.js install guide](https://nodejs.org/)
- Tại thư mục dự án NextJS, chạy:
  ```bash
  npm install
  npm run dev
  ```
- Truy cập dashboard qua địa chỉ: `http://localhost:3000`
- Đăng nhập bằng tài khoản admin.

### 3.2. Quản lý thiết bị & đơn hàng

- Theo dõi trạng thái thiết bị IoT (online/offline, trạng thái camera).
- Quản lý đơn hàng, xác nhận đơn, gửi lệnh trực tiếp tới thiết bị IoT.

---

## 4. Backend API (.NET 8)

### 4.1. Cài đặt và chạy backend

- Clone source code backend (.NET 8) về máy.
- Cài đặt .NET 8 SDK: [Download .NET 8](https://dotnet.microsoft.com/en-us/download/dotnet/8.0)
- Cấu hình các biến môi trường trong file `appsettings.json` hoặc `.env` (MQTT, database,...).
- Tại thư mục dự án, chạy:
  ```bash
  dotnet restore
  dotnet run
  ```
- Server sẽ khởi động tại địa chỉ cấu hình (mặc định: `http://localhost:5000`).

### 4.2. Kết nối các thành phần

- Backend nhận dữ liệu/tác vụ từ app Flutter, giao tiếp với thiết bị IoT qua MQTT hoặc HTTP.
- NextJS Admin giao tiếp với backend để quản lý dữ liệu.

---

## 5. Sơ đồ tổng quan hệ thống

```
[App Flutter] <--> [Backend API (.NET 8)] <--> [MQTT Broker] <--> [Thiết bị IoT: ESP32/ESP32-CAM]
       |                                   ^
       |                                   |
[NextJS Admin] -----------------------------
```

---

## 6. Lưu ý khi sử dụng

- Đảm bảo tất cả các thành phần đều kết nối cùng một mạng hoặc có thể truy cập được đến MQTT broker và backend.
- Khi gặp lỗi kết nối, kiểm tra lại thông tin WiFi, MQTT broker, API server và quyền truy cập mạng.
- Đảm bảo đã cài đủ các package/phụ thuộc cho từng thành phần.

---