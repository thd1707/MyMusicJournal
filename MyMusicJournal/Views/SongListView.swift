//
//  SongListView.swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
import SwiftUI

struct SongListView: View {
    @ObservedObject var songListVM: SongListViewModel
    
    @State private var selectedMoodFilter: String = "Tất cả"
    let moodOptions = ["Tất cả", "😄", "😢", "🕺🏻", "💗", "💤"]

    var filteredSongs: [Song] {
        if selectedMoodFilter == "Tất cả" {
            return songListVM.songs
        } else {
            return songListVM.songs.filter { $0.mood == selectedMoodFilter }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                Picker("Lọc theo cảm xúc", selection: $selectedMoodFilter) {
                    ForEach(moodOptions, id: \.self) { mood in
                        Text(mood)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(filteredSongs) { song in
                        HStack {
                            Text(song.mood)
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text(song.title)
                                    .font(.headline)
                                Button(action: {
                                    if let url = URL(string: song.link), UIApplication.shared.canOpenURL(url) {
                                        UIApplication.shared.open(url)
                                    }
                                }) {
                                    Text("Nghe bài này 🎧")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .onDelete(perform: deleteSongs)
                }
            }
            .navigationTitle("Danh sách bài hát")
            .toolbar {
                EditButton()
            }
        }
    }

    func deleteSongs(at offsets: IndexSet) {
        songListVM.songs.remove(atOffsets: offsets)
    }
}
