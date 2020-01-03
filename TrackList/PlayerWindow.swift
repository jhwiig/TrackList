//
//  PlayerWindow.swift
//  TrackList
//
//  Created by Jack Wiig on 12/25/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import Cocoa
import SwiftUI

class PlayerWindow: NSWindow, ObservableObject {
    
    // Interface Elements
    private var trackingArea: NSTrackingArea!
    private var player: WrappedAppleScriptInterface

    // UI State Element
    @Published var hovering: Bool = false
    
    override init(contentRect: NSRect,
                  styleMask style: NSWindow.StyleMask,
                  backing backingStoreType: NSWindow.BackingStoreType,
                  defer flag: Bool) {
        
        player = WrappedAppleScriptInterface(platform: .Spotify)
        super.init(contentRect: contentRect,
                   styleMask: style, backing: backingStoreType, defer: flag)
        
        let playerView = PlayerView()
            .environmentObject(player)
            .environmentObject(self)
        
        trackingArea = NSTrackingArea(rect: frame,
                                      options: [.activeAlways,
                                                .mouseEnteredAndExited,
                                                .inVisibleRect],
                                      owner: self, userInfo: nil)
        
        setFrameAutosaveName("Player Window")
        isMovableByWindowBackground = true
        
        aspectRatio = CGSize(width: 1, height: 1)
        
        level = .floating
        collectionBehavior = .canJoinAllSpaces

        contentView = NSHostingView(rootView: playerView)
        contentView?.addTrackingArea(trackingArea)
        
        makeKeyAndOrderFront(nil)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        hovering = true
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        hovering = false
    }
    
}
