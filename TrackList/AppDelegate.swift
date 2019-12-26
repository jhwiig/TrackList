//
//  AppDelegate.swift
//  TrackList
//
//  Created by Jack Wiig on 12/19/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var window: PlayerWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Create the main window
        window = PlayerWindow(
            contentRect: NSRect(x: 0, y: 0, width: 180, height: 180),
            styleMask: [.resizable, .fullSizeContentView],
            backing: .buffered, defer: false)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

