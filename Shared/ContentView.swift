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
    
    @FetchRequest(entity: NoteFolder.entity(), sortDescriptors: [])
    private var folders: FetchedResults<NoteFolder>
    
    @State var selectedFolder: NoteFolder? = nil
    @State var selectedCol: ColumnType = .none
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    List(selection: $selectedFolder) {
                        Section(header: Text("iCloud")) {
                            ForEach(folders, id: \.self) { folder in
                                NavigationLink(destination: FolderDetail(folder: folder, selectedCol: $selectedCol, selectedFolder: $selectedFolder)) {
                                    HStack {
                                        Text(folder.name!)
                                        Spacer()
                                        Text("\(folder.notesArr.count)")
                                            .foregroundColor(selectedFolder == folder ? Color.primary : Color.gray)
                                    }
                                }.contextMenu {
                                    Button(action: {
                                        viewContext.deleteFolder(folder)
                                    }) {
                                        Label("Delete Folder", systemImage: "trash")
                                    }.keyboardShortcut(KeyEquivalent.delete, modifiers: [])
                                    Button(action: {
                                        folder.name = "aaabb"
                                        viewContext.safeSave()
                                    }) {
                                        Label("Rename Folder", systemImage: "pencil")
                                    }
                                }
                            }.onDelete { offsets in
                                _ = offsets.map { i in
                                    viewContext.delete(folders[i])
                                }
                            }
                        }
                    }
                    .onChange(of: selectedFolder, perform: { _ in
                        selectedCol = .folderList
                    })
                    .listStyle(SidebarListStyle())
                    .frame(minWidth: 150)
                    .toolbar {
                        #if os(macOS)
                        ToolbarItem {
                            Button(action: {
                                toggleSidebar()
                            }, label: {
                                Label("Toggle sidebar", systemImage: "sidebar.left")
                            })
                        }
                        #endif
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            viewContext.addFolder("New Folder")
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
}

// MARK: FOLDER DETAIL
/// View displaying the contents of a folder of multiple notes
/// Contains a NavigationView for displaying NoteDetail views
struct FolderDetail: View {
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @ObservedObject var folder: NoteFolder
    
    @Binding var selectedCol: ColumnType
    @Binding var selectedFolder: NoteFolder?
    @State var selectedNote: Note? = nil
    
    var body: some View {
        List(selection: $selectedNote) {
            ForEach(folder.notesArr, id: \.self) { note in
                NavigationLink(destination: NoteDetail(note: note)) {
                    Text(note.title!)
                }
                .contextMenu {
                    Button(action: {
                        viewContext.deleteNote(note)
                    }) {
                        Label("Delete Note", systemImage: "trash")
                    }
                }
            }
            .onDelete { offsets in
                _ = offsets.map { i in
                    viewContext.delete(folder.notesArr[i])
                }
            }
        }
        .onChange(of: selectedNote, perform: { _ in
            selectedCol = .noteList
        })
        .frame(minWidth: 275)
        .navigationTitle(folder.name ?? "KeeperDiary")
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button(action: {
                    viewContext.addNote("New Note\(Int.random(in: 0...10000))", content: "", folder: folder)
                }, label: {
                    Label("New note", systemImage: "plus")
                })
            }
            
            ToolbarItem {
                Button(action: {
                    switch selectedCol {
                        case .folderList:
                            viewContext.deleteFolder(selectedFolder!)
                            
                        case .noteList:
                            viewContext.deleteNote(selectedNote!)
                        default:
                            break
                    }
                }, label: {
                    Label("Delete note", systemImage: "trash")
                })
                .keyboardShortcut(KeyEquivalent.delete, modifiers: [])
                .disabled(!isDeletePossible())
            }
        }
    }
    
    func isDeletePossible() -> Bool {
        if selectedCol == .none {
            return false
        }
        switch selectedCol {
            case .folderList:
                return selectedFolder != nil
                
            case .noteList:
                return selectedNote != nil
            default:
                return false
        }
    }
}

// MARK: NOTE DETAIL
/// View displaying the contents of a single note
struct NoteDetail: View {
    @State var note: Note
    @State var content = ""
    
    var body: some View {
        VStack {
            TextEditor(text: $content)
                .padding()
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.red)
//        .navigationTitle(note.title)
//        .navigationSubtitle(folder.name)
        .toolbar {
            ToolbarItem {
                Button(action: { }, label: {
                    Label("A", systemImage: "plus")
                })
            }
            
            ToolbarItem {
                HStack {
                    Spacer()
                }
            }
            
            ToolbarItem {
                Button(action: {
                    
                }, label: {
                    Label("A", systemImage: "plus")
                })
            }
        }
        .onAppear {
            content = note.content ?? ""
        }
    }
}
