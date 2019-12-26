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
    private var playerView: PlayerView!

    // UI State Element
    @Published var hovering: Bool = false
    
    override init(contentRect: NSRect,
                  styleMask style: NSWindow.StyleMask,
                  backing backingStoreType: NSWindow.BackingStoreType,
                  defer flag: Bool) {

        super.init(contentRect: contentRect,
                   styleMask: style, backing: backingStoreType, defer: flag)
        
        playerView = PlayerView(parentWindow: self)
        trackingArea = NSTrackingArea(rect: frame,
                                      options: [.activeAlways,
                                                .mouseEnteredAndExited,
                                                .inVisibleRect],
                                      owner: self, userInfo: nil)
        
        setFrameAutosaveName("Player Window")
        titlebarAppearsTransparent = true
        titleVisibility = .hidden
        isMovableByWindowBackground = true
        
        aspectRatio = CGSize(width: 1, height: 1)
        
        level = .floating
        collectionBehavior = .canJoinAllSpaces
        
        contentView = NSHostingView(rootView: playerView)
        contentView?.addTrackingArea(trackingArea)
        
        makeKeyAndOrderFront(nil)
        updateWindowButtons()
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        hovering = true
        updateWindowButtons()
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        hovering = false
        updateWindowButtons()
    }
    
    func updateWindowButtons() {
        standardWindowButton(.closeButton)?.isHidden = !hovering
        standardWindowButton(.miniaturizeButton)?.isHidden = !hovering
        standardWindowButton(.zoomButton)?.isHidden = !hovering
    }
}
