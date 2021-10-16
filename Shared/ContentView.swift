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
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var model: FetchedResults<NoteFolder>
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List {
                        Section(header: Text("iCloud")) {
                            ForEach(model, id: \.self) { folder in
                                NavigationLink(destination: FolderDetail(folder: folder)) {
                                    Text(folder.name!)
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
                    Spacer()
                    HStack {
                        Button(action: {
                            addFolder()
                        }) {
                            Label("New folder", systemImage: "plus.circle")
                        }.buttonStyle(BorderlessButtonStyle())
                        Spacer()
                    }.frame(maxWidth: .infinity).padding()
                }
                
                Text("No folder selected")
                
                Text("No note selected")
            }
        }
    }
    
    func addFolder() {
        let new = NoteFolder(context: viewContext)
        new.name = "Folder Test"
        new.notes = []
        viewContext.safeSave()
    }
}

// MARK: FOLDER DETAIL
/// View displaying the contents of a folder of multiple notes
/// Contains a NavigationView for displaying NoteDetail views
struct FolderDetail: View {
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @State var folder: NoteFolder
    
    var body: some View {
        List {
            ForEach(Array(folder.notes as? Set<Note> ?? []), id: \.self) { note in
                NavigationLink(destination: NoteDetail(note: note)) {
                    Text(note.title ?? "New Folder")
                }
            }
        }
        .frame(minWidth: 275)
        .navigationTitle(folder.name!)
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
    @State var note: Note
    
    var body: some View {
        VStack {
            Text(note.content ?? "")
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
