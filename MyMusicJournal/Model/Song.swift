//
//  Song.swift
//  MyMusicJournal
//
//  Created by TY on 07/06/2025.
//

import Foundation

struct Song: Identifiable, Codable {
    let id = UUID()
    let title: String
    let mood: String
    let link: String
}
