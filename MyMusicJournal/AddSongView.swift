//
//  AddSongView.swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
//
import SwiftUI

struct AddSongView: View {
    @ObservedObject var songListVM: SongListViewModel
    @Binding var selectedTab: Int

    @State private var title: String = ""
    @State private var selectedMood: String = "😄"
    @State private var link: String = ""
    let moodIcons = ["😄", "😢", "🕺🏻", "💗", "💤"]

    var body: some View {
        Form {
            Section(header: Text("Tên bài hát")) {
                TextField("Nhập tên bài hát", text: $title)
            }

            Section(header: Text("Chọn tâm trạng")) {
                Picker("Tâm trạng", selection: $selectedMood) {
                    ForEach(moodIcons, id: \.self) { icon in
                        Text(icon).tag(icon)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: Text("Link nghe bài hát")) {
                TextField("Nhập link nghe", text: $link)
                    .keyboardType(.URL)
                    .autocapitalization(.none)
            }

            Button(action: {
                let newSong = Song(title: title, mood: selectedMood, link: link)
                songListVM.addSong(newSong)

                // Reset
                title = ""
                link = ""
                selectedMood = "😄"

                // Chuyển sang tab "Danh sách"
                selectedTab = 1
            }) {
                Text("Thêm bài hát")
                    .frame(maxWidth: .infinity)
            }
            .disabled(title.isEmpty || link.isEmpty)
            .opacity((title.isEmpty || link.isEmpty) ? 0.5 : 1.0)
        }
        .navigationTitle("Thêm bài hát")
    }
}


struct AddSongView_Previews: PreviewProvider {
    static var previews: some View {
        AddSongView(songListVM: SongListViewModel(), selectedTab: .constant(0))
    }
}
