
# Healthy Heart (Flutter App)

Healthy Heart là ứng dụng theo dõi sức khỏe và dinh dưỡng được xây dựng bằng Flutter.
Ứng dụng hỗ trợ người dùng tính toán các chỉ số cơ thể (BMI, TDEE), quản lý món ăn hằng ngày và theo dõi tổng lượng calories nạp vào, từ đó giúp hình thành thói quen ăn uống khoa học hơn.

---

## Thông tin Nhóm Phát triển (Team Information)

Đề tài được thực hiện bởi nhóm sinh viên:

| Họ và Tên | Mã Số Sinh Viên (MSV) |
| :--- | :--- |
| **Tạ Diệu Hương** | 23010610 |
| **Bạch Phương Linh** | 23010562 |

---

## Lý do Thực hiện Đề tài (Motivation)

Trong cuộc sống hiện đại, mọi người ngày càng quan tâm hơn đến sức khỏe và dinh dưỡng, đặc biệt là việc kiểm soát lượng calories nạp vào cơ thể mỗi ngày. Tuy nhiên, việc tự ghi chép và tính toán các chỉ số như BMI, TDEE và tổng calories thường phức tạp và mất thời gian, nhất là với những người bận rộn.

Từ nhu cầu thực tế đó, em lựa chọn xây dựng ứng dụng Healthy Heart với mong muốn hỗ trợ người dùng theo dõi cơ thể và dinh dưỡng một cách đơn giản, trực quan hơn. Ứng dụng còn giúp người dùng dễ dàng lựa chọn được bài tập phù hợp với thể trạng và mục tiêu riêng của họ.

Thông qua việc thực hiện đề tài, em cũng mong muốn củng cố kỹ năng lập trình Flutter và xây dựng một sản phẩm có ý nghĩa thực tiễn, có thể hỗ trợ người dùng hình thành thói quen sống lành mạnh và khoa học hơn.

---

## Sơ đồ Use case
<img width="975" height="264" alt="image" src="https://github.com/user-attachments/assets/c98eac17-8acb-47f4-b295-1a56e569e392" />

---

## Tính năng chính của ứng dụng

• Tính BMI & TDEE: Người dùng nhập thông tin cá nhân, hệ thống tính BMI và TDEE, đồng thời đề xuất mức calo phù hợp.
• Quản lý món ăn: Người dùng có thể thêm hoặc xóa món ăn bằng cách nhập tên món, lượng calo và các thông tin dinh dưỡng; hệ thống lưu lại và cập nhật tổng calo trong ngày.
• Theo dõi calo trong ngày: Khi người dùng thêm món ăn, hệ thống cộng dồn calo và chất dinh dưỡng; vòng tròn calo đổi màu theo mức tiêu thụ.
• Lịch sử ăn uống: Lưu và hiển thị danh sách các món đã ăn theo từng ngày.
• Theo dõi tập luyện: Hiển thị danh sách bài tập và gợi ý thời lượng tập luyện phù hợp.
• Quản lý ghi chú: Người dùng có thể thêm, sửa hoặc xóa các ghi chú cá nhân.


---


## Công nghệ sử dụng

•	Flutter (Dart)
•	Kiến trúc StatefulWidget để quản lý trạng thái (state) cục bộ cho màn hình chính.


---


## Cài đặt và chạy

**Yêu cầu hệ thống**
-	Flutter >= 3.0
-	Dart >= 3.0
-	IDE: VS Code

**Hướng dẫn chạy**
```
# Clone repository về máy
git clone <link-repo>   

# Vào thư mục dự án
cd <ten-thu-muc-du-an> 

# Cài đặt các thư viện cần thiết
flutter pub get

# Chạy ứng dụng
flutter run




