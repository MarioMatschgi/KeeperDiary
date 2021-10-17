//
//  Data.swift
//  KeeperDiary
//
//  Created by Mario Elsnig on 17.10.21.
//

import SwiftUI
import CoreData

enum ColumnType {
    case none
    case folderList
    case noteList
}

extension NoteFolder {
    public var notesArr: [Note] {
        let set = notes as? Set<Note> ?? []
        
        return set.sorted { note1, note2 in
            return note1.dateModified! > note2.dateModified!
        }
    }
}

extension NSManagedObjectContext {
    func addNote(_ name: String, content: String, folder: NoteFolder) {
        withAnimation {
            let new = Note(context: self)
            new.title = name
            new.content = content
            new.dateCreated = Date()
            new.dateModified = Date()
            new.folder = folder
            self.safeSave()
        }
    }
    func deleteNote(_ note: Note) {
        withAnimation {
            self.delete(note)
            self.safeSave()
        }
    }
    
    func addFolder(_ name: String, notes: [Note] = []) {
        withAnimation {
            let new = NoteFolder(context: self)
            new.name = name
            new.notes = NSSet(array: notes)
            self.safeSave()
        }
    }
    func deleteFolder(_ folder: NoteFolder) {
        withAnimation {
            self.delete(folder)
            self.safeSave()
        }
    }
}
