//
//  ContentView.swift
//  Shared
//
//  Created by Mario Elsnig on 09.10.21.
//

import SwiftUI

// MARK: CONTENT VIEW
/// View for all content of the app
struct ContentView: View {
    @ObservedObject var model = NotesOO()
    
    @State var destination: String = "Toolbar Test"
    @State var detail: String = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("iCloud")) {
                    ForEach(model.folders, id: \.id) { folder in
                        NavigationLink(destination: FolderDetail(folder: folder)) {
                            Text(folder.name)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .toolbar {
                ToolbarItem {
                    Button(action: { }, label: {
                        Image(systemName: "sidebar.right")
                    })
                }
            }
            
            Text("No folder selected")
            
            Text("No note selected")
        }
        .navigationTitle(destination)
        #if(macOS)
        .navigationSubtitle(detail)
        #endif
        .onAppear {
            model.folders = [
                NoteFolder(name: "All", notes: [
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla"),
                    NoteModel(title: "Test", content: "Blabla")
                ])
            ]
        }
    }
}

// MARK: FOLDER DETAIL
/// View displaying the contents of a folder of multiple notes
/// Contains a NavigationView for displaying NoteDetail views
struct FolderDetail: View {
    @State var folder: NoteFolder
    
    var body: some View {
        List {
            ForEach(folder.notes, id: \.id) { note in
                NavigationLink(destination: NoteDetail(note: note)) {
                    Text(note.title)
                }
            }
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: { }, label: {
                    Image(systemName: "plus.circle")
                })
            }
            
            ToolbarItem {
                Button(action: { }, label: {
                    Image(systemName: "trash")
                })
            }
        }
    }
}

// MARK: NOTE DETAIL
/// View displaying the contents of a single note
struct NoteDetail: View {
    @State var note: NoteModel
    
    var body: some View {
        VStack {
            Text(note.content)
        }
        .navigationTitle(note.title)
        .toolbar(id: "n") {
            ToolbarItem(id: "ASD") {
                    
                Button(action: { }, label: {
                    Image(systemName: "plus")
                })
            }
            
            ToolbarItem(id: "spacer", showsByDefault: true) {
                HStack {
                    Spacer()
                }
            }
            
            ToolbarItem(id: "AaaaSD") {
                Button(action: { }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
}
