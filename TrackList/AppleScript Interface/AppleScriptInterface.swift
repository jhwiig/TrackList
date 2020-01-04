//
//  AppleScriptInterface.swift
//  TrackList
//
//  Created by Jack Wiig on 12/20/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import Foundation

// MARK: - AppleScript Interface

/// Protocol that standardizes an AppleScript Interface for Audio Players
@objc(NSObject) protocol PlayerAppleScriptInterface {
    var trackName: NSString { get }
    var trackArtist: NSString { get }
    var trackAlbum: NSString { get }
    var trackArtworkURL: NSString { get }
    var trackLength: NSNumber { get }
    var trackURL: NSString { get set }
    
    var soundVolume: NSNumber { get set }
    var playerState: NSNumber { get }
    var playerPosition: NSNumber { get set }
    var repeatingEnabled: NSNumber { get }
    var repeating: NSNumber { get set }
    var shufflingEnabled: NSNumber { get }
    var shuffling: NSNumber { get set }
    
    func togglePlayPause()
    func setPlaying()
    func playTrack(track: NSString)
    func setPaused()
    func setNext()
    func setPrevious()
    func focus()
}
