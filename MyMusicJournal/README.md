🟢 Giai đoạn 1: Nền tảng & Dữ liệu
1.1. Khởi tạo Project SwiftUI
Mở Xcode → Tạo project mới → Chọn App, đặt tên là MyMusicJournal.


Interface chọn SwiftUI, ngôn ngữ là Swift.


Cấu trúc dự án chia theo MVC:


Model → Song.swift


ViewModel → SongListViewModel.swift


View → ContentView.swift, AddSongView.swift, SongListView.swift



1.2. Định nghĩa Model Song.swift
Tạo struct Song: Identifiable, Codable để đại diện cho từng bài hát.


Gồm các thuộc tính:


id: UUID để định danh duy nhất.


title: tên bài hát (String)


mood: biểu tượng cảm xúc (emoji dạng String, ví dụ "🥰", "😢")


note: ghi chú cá nhân ngắn gọn (String, có thể để trống)


link: URL ngoài để mở bài hát (Spotify, YouTube,...)


👉 Mục đích: Là đơn vị dữ liệu cơ bản mà app lưu trữ và hiển thị.

1.3. Tạo ViewModel SongListViewModel.swift
Tạo class SongListViewModel: ObservableObject


Gồm:


@Published var songs: [Song]: danh sách tất cả bài hát. Dùng @Published để tự động cập nhật giao diện khi có thay đổi.


Hàm addSong(_:): thêm bài mới vào danh sách.


Hàm removeSong(at:): xoá bài khỏi danh sách.


👉 Mục đích: Quản lý dữ liệu trung tâm, chia sẻ giữa các View bằng cách truyền biến.

🟡 Giai đoạn 2: Xây dựng Giao diện (UI)
2.1. Giao diện Thêm Bài – AddSongView.swift
Giao diện sử dụng Form để chia thành các section rõ ràng:


Tên bài hát – TextField


Chọn cảm xúc – Picker hiển thị emoji


Link bài hát – TextField cho phép nhập URL


(Tuỳ chọn) Ghi chú – TextField


Nút “Thêm bài hát” – Button


Khi nhấn:


Tạo đối tượng Song


Gọi songListVM.addSong()


Xoá nội dung các trường nhập liệu (reset)


Chuyển sang tab "Danh sách" bằng $selectedTab = 1


👉 Điểm chú ý:
Section giúp chia rõ từng phần nhập liệu.


Button được .disabled nếu title hoặc link bị bỏ trống, tránh người dùng nhập thiếu.


Sử dụng @Binding var selectedTab để điều khiển TabView từ xa.



2.2. Giao diện Danh sách – SongListView.swift
Dùng List để hiển thị các bài hát đã lưu.


Mỗi dòng (HStack) gồm:


Emoji biểu tượng cảm xúc (Text(song.mood))


Tên bài hát và nút nghe bài:


Text(song.title)


Button(action: ...) mở link bài hát:

 if let url = URL(string: song.link), UIApplication.shared.canOpenURL(url) {
    UIApplication.shared.open(url)
}
Cho phép vuốt trái để xoá bài hát (qua .onDelete(perform:))



2.3. Thêm tính năng lọc cảm xúc
Thêm Picker dạng SegmentedPickerStyle để chọn emoji lọc.


Dùng biến @State private var selectedMoodFilter để lưu mood được chọn.


Biến filteredSongs tự động lọc songs theo cảm xúc đó.


Danh sách hiện filteredSongs thay vì toàn bộ songs.


👉 Lợi ích: Giúp người dùng tìm bài hát theo tâm trạng một cách trực quan, nhanh chóng.

🔵 Giai đoạn 3: Hoàn thiện Luồng Ứng dụng
3.1. Điều hướng qua ContentView.swift
App dùng TabView để chuyển giữa 2 màn hình:


Tab 1: AddSongView → Thêm bài hát


Tab 2: SongListView → Danh sách bài hát


Truyền cùng một @StateObject var songListVM vào cả hai view để chia sẻ dữ liệu.


👉 Cách hoạt động:
Khi người dùng thêm bài hát → songListVM.addSong() cập nhật danh sách


Biến songs là @Published nên SongListView tự động cập nhật



3.2. Chuyển tab sau khi thêm bài hát
Trong AddSongView, sau khi nhấn “Thêm bài hát”, gán selectedTab = 1


Nhờ TabView(selection: $selectedTab), app sẽ chuyển qua tab Danh sách

3.3. Tối ưu UI
Font chữ rõ ràng (.headline, .largeTitle cho emoji)


Khoảng cách (.padding(.vertical, 8)) giúp mỗi hàng nhìn thoáng


Màu sắc: dùng màu hệ thống như .blue cho link để dễ nhận biết


Số emoji cảm xúc vừa đủ (5-6 cái), tránh quá tải




