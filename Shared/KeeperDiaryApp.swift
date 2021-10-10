//
//  KeeperDiaryApp.swift
//  Shared
//
//  Created by Mario Elsnig on 09.10.21.
//

import SwiftUI

@main
struct KeeperDiaryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowToolbarStyle(UnifiedWindowToolbarStyle())
        .commands {
            SidebarCommands()
        }
    }
}
