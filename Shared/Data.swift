//
//  Data.swift
//  KeeperDiary
//
//  Created by Mario Elsnig on 09.10.21.
//

import Foundation

class NotesOO: ObservableObject {
    @Published var folders: [NoteFolder] = []
}

struct NoteFolder: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var name: String
    var notes: [NoteModel]
}

struct NoteModel: Codable, Hashable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var content: String
}
