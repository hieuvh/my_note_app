# mynote
**Bài thu hoạch:**
Xây dựng ứng dụng Note (Đây là phần thực hành của nội dung chương 4 trong học phần Phát triển ứng dụng di động đa nền tảng đang được giảng dạy tại Khoa Công nghệ thông tin của Trường Đại học Mỏ - Địa chất)

## Trong project bao gồm:
1. **Kiến trúc MVVM cơ bản.**
2. **Các chức năng: Xem, Thêm, Sửa, Xoá.**
3. **Bao gồm 2 view:**
* View 1 gồm: Xem, Thêm, Xoá ghi chú.
* View 2 gồm: Sửa ghi chú.
4. **Sử dụng sqflite lưu trữ dữ liệu.**
5. **Sử dụng các widget mức cơ bản như: Async, Layout, Styling, Input, Text, Icons**

## Mô tả các bước tạo project:
1. Trong Visual Studio Code chọn **View -> Command Palette…** hoặc nhấn tổ hợp **Ctrl + Shift + P**.

2. Nhập vào Flutter và Chọn **Flutter: New Project**.

3. Nhập tên ứng dụng / project và nhấn **Enter**.

4. Tạo mới hoặc chọn thư mục lưu trữ project

5. Đợi quá trình tạo các tệp project hoàn tất và xuất hiện tệp main.dart
 * Ta có thể chỉnh sửa code tại tệp main.dart hoặc tạo các tệp dart mới cho project
 * Thêm các cấu hình cho project trong file pubspec.yaml

6. Chạy và Debug cho project bằng cách chọn **Run -> Start Debugging** hoặc nhấn **F5**.

## Các kết quả đã làm được trong project:

1. **Xem và Thêm ghi chú**
![1](https://raw.githubusercontent.com/hieuvh/my_note_app/master/images/them.png)

2. **Sửa ghi chú**
 * 2.1: Giao diện sửa ghi chú:
![2.1](https://raw.githubusercontent.com/hieuvh/my_note_app/master/images/sua1.png)

 * 2.2: Sau khi lưu ghi chú đã sửa:
![2.2](https://raw.githubusercontent.com/hieuvh/my_note_app/master/images/sua2.png)

3. **Xoá ghi chú**
 * 3.1: Trước khi xoá:
![3.1](https://raw.githubusercontent.com/hieuvh/my_note_app/master/images/sua2.png)

 * 3.2 Sau khi xoá: Tieu de 3 đã bị xoá khỏi danh sách ghi chú
![3.2](https://raw.githubusercontent.com/hieuvh/my_note_app/master/images/xoa.png)

## Tài liệu tham khảo

[Bài mẫu của giảng viên - Trần Trung Chuyên](https://github.com/chuyentt/mynote)

Tham khảo bài hướng dẫn tại [Navigation - Flutter](https://flutter.dev/docs/cookbook/navigation)

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.