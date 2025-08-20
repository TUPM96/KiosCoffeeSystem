# KiosCoffeeSystem

**KiosCoffeeSystem** là hệ thống quản lý quán cà phê gồm hai phần: Backend sử dụng .NET Core 8 và Frontend sử dụng Next.js.

## Công nghệ sử dụng

- **Backend**: ASP.NET Core 8
- **Frontend**: Next.js

---

## Hướng dẫn cài đặt

### 1. Cài đặt Backend (.NET Core 8)

#### Yêu cầu
- .NET 8 SDK: [Tải về tại đây](https://dotnet.microsoft.com/download/dotnet/8.0)
- SQL Server (hoặc cấu hình lại nếu dùng DB khác)

#### Các bước

```bash
# Di chuyển vào thư mục backend
cd backend

# Khôi phục các gói NuGet
dotnet restore

# Chạy ứng dụng
dotnet run
```

- Mặc định backend sẽ chạy ở `http://localhost:5000` (có thể thay đổi trong file cấu hình).

### 2. Cài đặt Frontend (Next.js)

#### Yêu cầu
- Node.js (>= 18): [Tải về tại đây](https://nodejs.org/)
- npm hoặc yarn

#### Các bước

```bash
# Di chuyển vào thư mục frontend
cd frontend

# Cài đặt các package
npm install
# hoặc
yarn install

# Chạy ứng dụng
npm run dev
# hoặc
yarn dev
```

- Mặc định frontend sẽ chạy ở `http://localhost:3000`.

---

## Hướng dẫn sử dụng

1. Khởi động backend trước.
2. Khởi động frontend.
3. Truy cập frontend tại [http://localhost:3000](http://localhost:3000).
4. Đăng nhập và sử dụng các chức năng quản lý quán cà phê.

---

## Cấu hình kết nối

- Đảm bảo frontend trỏ đúng API backend bằng cách cập nhật endpoint trong file `.env` hoặc cấu hình tương ứng bên frontend.

```env
NEXT_PUBLIC_API_URL=http://localhost:5000
```

---
