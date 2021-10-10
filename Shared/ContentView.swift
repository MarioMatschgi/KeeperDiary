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
            .frame(minWidth: 150)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        toggleSidebar()
                    }, label: {
                        Label("Toggle sidebar", systemImage: "sidebar.left")
                    })
                }
            }
            
            Text("No folder selected")
            
            Text("No note selected")
        }
        .onAppear {
            model.folders = [
                NoteFolder(name: "All", notes: [
                    NoteModel(title: "Test01", content: "Blabla01"),
                    NoteModel(title: "Test02", content: "Blabla02"),
                    NoteModel(title: "Test03", content: "Blabla03"),
                    NoteModel(title: "Test04", content: "Blabla04"),
                    NoteModel(title: "Test05", content: "Blabla05"),
                    NoteModel(title: "Test06", content: "Blabla06"),
                    NoteModel(title: "Test07", content: "Blabla07"),
                    NoteModel(title: "Test08", content: "Blabla08"),
                    NoteModel(title: "Test09", content: "Blabla09"),
                    NoteModel(title: "Test10", content: "Blabla10"),
                    NoteModel(title: "Test11", content: "Blabla11"),
                    NoteModel(title: "Test12", content: "Blabla12")
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
                NavigationLink(destination: NoteDetail(note: note, folder: folder)) {
                    Text(note.title)
                }
            }
        }
        .frame(minWidth: 275)
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: { }, label: {
                    Label("New note", systemImage: "plus")
                })
            }
            
            ToolbarItem {
                Button(action: { }, label: {
                    Label("Delete note", systemImage: "trash")
                })
            }
        }
    }
}

// MARK: NOTE DETAIL
/// View displaying the contents of a single note
struct NoteDetail: View {
    @State var note: NoteModel
    @State var folder: NoteFolder
    
    var body: some View {
        VStack {
            Text(note.content)
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.red)
//        .navigationTitle(note.title)
//        .navigationSubtitle(folder.name)
        .toolbar {
            ToolbarItem {
                Button(action: { }, label: {
                    Image(systemName: "plus")
                })
            }
            
            ToolbarItem {
                HStack {
                    Spacer()
                }
            }
            
            ToolbarItem {
                Button(action: { }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
}
