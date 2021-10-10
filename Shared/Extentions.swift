//
//  Extentions.swift
//  KeeperDiary
//
//  Created by Mario Elsnig on 09.10.21.
//

import Foundation
import SwiftUI

func toggleSidebar() {
    #if os(macOS)
    NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    #endif
}
