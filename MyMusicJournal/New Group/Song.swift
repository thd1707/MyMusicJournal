//
//  Song.swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
//


import Foundation

struct Song: Identifiable {
    let id = UUID()
    var title: String
    var moodIcon: String
    var note: String
    var link: String
}
