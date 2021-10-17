//
//  Extentions.swift
//  KeeperDiary
//
//  Created by Mario Elsnig on 09.10.21.
//

import Foundation
import SwiftUI
import CoreData

func toggleSidebar() {
    #if os(macOS)
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    #endif
}

extension NSManagedObjectContext {
    func safeSave() {
        do {
            try self.save()
        } catch {
            fatalError("Error saving: \(error)")
        }
    }
}
