//
//  SongListViewModel.swift .swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
//

import Foundation
import Combine

class SongListViewModel: ObservableObject {
    @Published var songs: [Song] = [] {
        didSet {
            saveSongs()
        }
    }

    init() {
        loadSongs()
    }

    func addSong(_ song: Song) {
        songs.append(song)
    }

    // MARK: - Save & Load

    private func saveSongs() {
        if let encoded = try? JSONEncoder().encode(songs) {
            UserDefaults.standard.set(encoded, forKey: "SavedSongs")
        }
    }

    private func loadSongs() {
        if let data = UserDefaults.standard.data(forKey: "SavedSongs"),
           let decoded = try? JSONDecoder().decode([Song].self, from: data) {
            songs = decoded
        }
    }
}
