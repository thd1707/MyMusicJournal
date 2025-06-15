//
//  ContentView.swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject var songListVM = SongListViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                AddSongView(songListVM: songListVM, selectedTab: $selectedTab)
                    .tabItem {
                        Label("Thêm bài", systemImage: "plus.circle")
                    }
                    .tag(0)

                SongListView(songListVM: songListVM)
                    .tabItem {
                        Label("Danh sách", systemImage: "list.bullet")
                    }
                    .tag(1)
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
