# ĐỒ ÁN NHẬP MÔN CÔNG NGHỆ PHẦN MỀM  
## Đề tài: Hệ thống Quản lý Sổ Tiết Kiệm

---

### LỜI MỞ ĐẦU

Đây là sản phẩm đồ án môn học *Nhập môn Công nghệ Phần mềm*, được thực hiện bởi **nhóm 6A** dưới sự hướng dẫn tận tình của **thầy Trần Duy Hoàng**. Đề tài của chúng tôi là xây dựng **Hệ thống quản lý sổ tiết kiệm**, nhằm mô phỏng quy trình tạo và quản lý các loại hình tiết kiệm của người dùng một cách khoa học và hiệu quả.

---

### CÔNG NGHỆ SỬ DỤNG

Trong suốt quá trình phát triển hệ thống, nhóm đã lựa chọn và triển khai các công nghệ sau:

- **Front-end**: HTML, CSS và JavaScript  
- **Back-end**: JavaScript với môi trường Node.js  
- **Cơ sở dữ liệu**: PostgreSQL

---

### HƯỚNG DẪN CÀI ĐẶT & CHẠY PROJECT TRÊN MÁY LOCAL

Để khởi chạy hệ thống trên máy tính cá nhân, vui lòng thực hiện các bước sau:

1. **Yêu cầu hệ thống**:
   - Máy tính đã cài đặt **Node.js** và **PostgreSQL**.
2. **Các bước thực hiện**:
   - **Bước 1**: Mở Command Prompt, dùng lệnh `cd` để điều hướng tới thư mục chứa project.
   - **Bước 2**: Chạy lệnh `npm i` để cài đặt các gói phụ thuộc.
   - **Bước 3**: Tạo một cơ sở dữ liệu mới trong PostgreSQL và chạy file `nmcnpm_postgre.sql` để khởi tạo các bảng cần thiết.
   - **Bước 4**: Cập nhật thông tin kết nối trong file `cnStr.js` (nằm trong thư mục `config`) cho phù hợp với cấu hình cơ sở dữ liệu vừa tạo (tên DB, mật khẩu, v.v.).
   - **Bước 5**: Chạy server bằng lệnh `npm start`, sau đó truy cập trình duyệt theo cổng hiển thị để sử dụng hệ thống.

---

### VIDEO DEMO ĐỒ ÁN  
*(Đường dẫn sẽ được đính kèm hoặc trình bày tại buổi báo cáo)*
https://www.youtube.com/watch?v=lEZOF5KCcvg
---

### CÁC CHỨC NĂNG CHÍNH ĐÃ HOÀN THÀNH

- Đăng ký và đăng nhập tài khoản người dùng
- Tạo sổ tiết kiệm với 3 loại:
  - **Không kỳ hạn**
  - **Kỳ hạn 3 tháng**
  - **Kỳ hạn 6 tháng**
- Gửi thêm tiền hoặc rút tiền tự do đối với sổ không kỳ hạn
- Rút tiền (có lãi) khi đến ngày đáo hạn của sổ có kỳ hạn
- Tái tục sổ khi đến hạn: chọn tiếp tục gửi hoặc rút hết
- Quản lý thông tin cá nhân (cập nhật hồ sơ)
- Hiển thị biến động số dư: chi tiết tiền đã gửi hoặc rút theo tháng

---

### ĐỊNH HƯỚNG PHÁT TRIỂN TRONG TƯƠNG LAI

- Hoàn thiện chức năng **tái tục**, tăng số lần gửi cho sổ khi tiếp tục gửi lại sau kỳ hạn
- Nâng cấp hệ thống thông báo biến động số dư: thêm thông tin rút tiền và tối ưu hóa truy vấn cơ sở dữ liệu
- Sửa các lỗi nhỏ phát hiện được trong quá trình kiểm thử
- **Triển khai (deploy)** hệ thống thành một phần mềm thực tế trên môi trường web
- Phát triển tính năng **báo cáo tài chính chi tiết theo tháng**, hỗ trợ xuất ra **file in ấn**
- Tìm giải pháp linh hoạt để người quản trị có thể **thay đổi quy định gửi tiền** (như kỳ hạn, số tiền tối thiểu) mà vẫn bảo toàn dữ liệu cũ
- Thiết kế giao diện trực quan hơn, hướng đến **single-page application (SPA)**

---

### KẾT LUẬN

Đồ án là kết quả của tinh thần làm việc nghiêm túc, đoàn kết của cả nhóm. Chúng tôi hy vọng hệ thống quản lý sổ tiết kiệm này có thể trở thành nền tảng cho những phát triển sâu rộng hơn trong tương lai. Nhóm rất mong nhận được góp ý từ thầy cô và bạn bè để hoàn thiện sản phẩm tốt hơn nữa.
