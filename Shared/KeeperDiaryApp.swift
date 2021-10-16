//
//  KeeperDiaryApp.swift
//  Shared
//
//  Created by Mario Elsnig on 09.10.21.
//

import SwiftUI

@main
struct KeeperDiaryApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
//                    _ = iCloudManager()
                }
        }
        .commands {
            SidebarCommands()
        }
    }
}
