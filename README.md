#  BTL-KTMT-PTIT – Bài Tập Lớn Kiến Trúc Máy Tính (Assembly 8086)

##  Giới thiệu
Bài tập lớn môn **Kiến trúc máy tính (KTMT)** tại Học viện Công nghệ Bưu chính Viễn thông – PTIT.  
Bao gồm bài tập cá nhân và bài tập nhóm được lập trình bằng Assembly 8086.<br>
**Giảng viên**: Trần Tiến Công - **Khóa**: D23


---

##  Bài tập cá nhân

###  Bài số 1: Lập trình Assembly
Các bài đã thực hiện: **1, 2, 4, 5, 6, 7, 8, 10, 11, 12, 13, 16**.  

####  Danh sách đề bài
1. In ra lời chào Tiếng Anh và Tiếng Việt.  
2. Nhập 1 ký tự và in ra màn hình.  
3. Nhập 1 chuỗi ký tự và in ra chuỗi đó.  
4. Nhập 1 ký tự viết thường và in ra chữ hoa tương ứng.  
5. Nhập 1 chuỗi ký tự, in ra dạng viết hoa và viết thường.  
6. Nhập chuỗi ký tự kết thúc bởi `#`, in ra theo thứ tự ngược lại.  
7. Chuyển số từ hệ cơ số 10 sang nhị phân.  
8. Chuyển số từ hệ cơ số 10 sang hệ 16 (Hexa).  
9. Nhập số nhị phân (8 bit) vào BL, kiểm tra hợp lệ, xuất ra hệ 16.  
10. Đếm chiều dài chuỗi ký tự.  
11. Tìm giá trị lớn nhất và nhỏ nhất của mảng số.  
12. Tính giai thừa của số nhập vào.  
13. Tính tổng các số nhập vào.  
14. Nhập 2 số, in ra ƯCLN và BCNN.  
15. In ra số lượng và tổng các số chia hết cho 11.  
16. Tính tổng 2 số kiểu word.  
17. Nhập mảng 10 số có hai chữ số, tính tổng các số chia hết cho 7.  
18. Đếm số lần xuất hiện chuỗi con `"ktmt"` trong chuỗi.  
19. Kiểm tra chuỗi B có phải là chuỗi con của A, in vị trí nếu có.  
20. Đếm số lần chuỗi B xuất hiện trong A.  

---

###  Bài số 2: Phân tích khảo sát hệ thống bộ nhớ
1. Khảo sát cấu hình máy và hệ thống bộ nhớ (ROM, RAM, Cache, ổ cứng, CD, thiết bị I/O).  
2. Dùng công cụ **Debug** khảo sát nội dung các thanh ghi: IP, DS, ES, SS, CS, BP, SP.  
3. Giải thích nội dung các thanh ghi và cơ chế quản lý bộ nhớ trong trường hợp cụ thể.  

---

##  Bài tập nhóm

###  Balloon Shooting Game

**Balloon Shooting Game** là trò chơi bắn bóng bay viết bằng **Assembly 8086**.  
Người chơi điều khiển nhân vật bắn mũi tên tiêu diệt bóng bay, **thắng** khi đạt số điểm mục tiêu và **thua** nếu để lọt quá nhiều bóng.  

####  Mục tiêu
- Bắn trúng các bóng bay di chuyển từ dưới lên bên phải màn hình.  

####  Cách chơi
- `W`: Di chuyển lên trên  
- `S`: Di chuyển xuống dưới  
- `SPACE`: Bắn mũi tên từ vị trí người chơi sang phải  

####  Điều kiện thắng
- Bắn trúng **2 quả bóng bay** (`hits = 2`).  
- (Có thể chỉnh để tăng độ khó).  

####  Điều kiện thua
- Để lọt **5 quả bóng bay** (`miss = 5`).  
- (Có thể chỉnh để thay đổi thử thách).  

#### 📸 Hình ảnh minh họa
<p align="center">
  <img width="600" alt="Screenshot 1" src="https://github.com/user-attachments/assets/e5a02f8c-a14a-4326-9c32-3fd2fca082c6" />
</p>
<p align="center">
  <img width="600" alt="Screenshot 2" src="https://github.com/user-attachments/assets/9d7e0eb3-1a27-4e9b-a867-c5008a1bb2d6" />
</p>
<p align="center">
  <img width="600" alt="Screenshot 3" src="https://github.com/user-attachments/assets/04167b2f-0a39-4447-9611-e3ed249c5bba" />
</p>


---

## Công cụ sử dụng
-  **Emu8086 Microprocessor Emulator**
  👉 [Link tải Google Drive](https://drive.google.com/drive/folders/1-x8CeO0sy8qNzbKGqamVcDdYBdtSf0RN?usp=drive_link)  
  *(Trang chủ Emu8086 hiện không truy cập được, nhiều bản trên mạng kèm PUP / Adware như Avast hoặc McAfee ).*  
-  **CPU-Z** (phân tích cấu hình máy)  

## 🔗 Tham khảo
Code được tham khảo và sửa đổi dựa trên phiên bản mã nguồn mở.<br>
Tham khảo mã nguồn gốc tại đây: 
[**Assembly- Balloon Shooting Game**](https://github.com/Rezve/8086-Microprocessor-Game-in-Assembly-Language) 

![Visitor Count](https://komarev.com/ghpvc/?username=ThaiNT960&repo=BTL-KTMT-PTIT&color=blue&style=flat-square)
