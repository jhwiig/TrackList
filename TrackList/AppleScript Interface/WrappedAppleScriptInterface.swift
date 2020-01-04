//
//  WrappedAppleScriptInterface.swift
//  TrackList
//
//  Created by Jack Wiig on 12/19/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

// MARK: - Wrapped AppleScript Interface

import Foundation
import AppleScriptObjC

/// Middle man class between the AppleScript Interface (to the source player) and UI that pushes updates via fetching
class WrappedAppleScriptInterface: NSObject, ObservableObject {
    var objectWillChange = NotificationCenter.default.publisher(for: .interfaceUpdated)
        .receive(on: RunLoop.main)
    
    private var interface: PlayerAppleScriptInterface
    private var fetchTimer: Timer!
    let fetchRate: Double = 1
    
    // MARK: Computed Properties
    
    // Computed properties to safely type convert from AppleScriptObjc Object
    var trackName: String { interface.trackName as String }
    var trackArtist: String { interface.trackArtist as String }
    var trackAlbum: String { interface.trackAlbum as String }
    var trackArtworkURL: String { interface.trackArtworkURL as String }
    // NOTE: Spotify gives track length in milliseconds. This may vary per platform
    var trackLength: Double { Double(truncating: interface.trackLength) / 1000 }
    var trackURL: String {
        get { interface.trackURL as String }
        set(newURL) { interface.trackURL = newURL as NSString }
    }
    var volume: Int {
        get { Int(truncating: interface.soundVolume) }
        set(newVolume) { interface.soundVolume = NSNumber(value: newVolume) }
    }
    var playerState: PlayerState {
        PlayerState.init(rawValue: Int(truncating: interface.playerState))!
    }
    var playerPosition: Double {
        get { Double(truncating: interface.playerPosition) }
        set(newPos) { interface.playerPosition = NSNumber(value: newPos) }
    }
    var repeatingEnabled: Bool { interface.repeatingEnabled.boolValue }
    var repeating: Bool {
        get { interface.repeating.boolValue }
        set(newState) { interface.repeating = NSNumber(value: newState) }
    }
    var shufflingEnabled: Bool { interface.shufflingEnabled.boolValue }
    var shuffling: Bool {
        get { interface.shuffling.boolValue }
        set(newState) { interface.shuffling = NSNumber(value: newState) }
    }
    
    // MARK: Interface Methods
    
    func togglePlayback() { interface.togglePlayPause() }
    func play() { interface.setPlaying() }
    func play(track: String) { interface.playTrack(track: track as NSString) }
    func pause() { interface.setPaused() }
    func next() { interface.setNext() }
    func previous() { interface.setPrevious() }
    func focus() { interface.focus() }
    
    // MARK: Wrapper Methods
    
    init(platform: PlayerType) {
        Bundle.main.loadAppleScriptObjectiveCScripts()
        interface = WrappedAppleScriptInterface.loadInterface(name: platform.rawValue)
        super.init()
        
        // 1 second timer to fetch information
        fetchTimer = Timer(timeInterval: fetchRate,
                           target: self, selector: #selector(fetchData), userInfo: nil,
                           repeats: true)
        RunLoop.main.add(fetchTimer, forMode: .common)
    }
    
    @objc func fetchData() {
        NotificationCenter.default.post(name: .interfaceUpdated, object: self)
    }
    
    static func loadInterface(name: String) -> PlayerAppleScriptInterface {
        let interface: AnyClass? = NSClassFromString(name + "Interface")
        let interfaceObject = interface!.alloc()
        return interfaceObject as! PlayerAppleScriptInterface
    }
}

extension Notification.Name {
    static let interfaceUpdated = Notification.Name("interfaceUpdated")
}

// MARK: - Helper Structures

class TimestampFormatter {
    static func fromTimeInSeconds(_ timeInSeconds: Int) -> String {
        let hours: Int = timeInSeconds / 3600
        let minutes: Int = timeInSeconds % 3600 / 60
        let seconds: Int = timeInSeconds % 60
        
        let leadingZeroSeconds = seconds < 10 ? "0" : ""
        
        if hours != 0 {
            let leadingZeroMinutes = minutes < 10 ? "0" : ""
            return String(hours)
                + ":" + leadingZeroMinutes + String(minutes)
                + ":" + leadingZeroSeconds + String(seconds)
        }
        
        return String(minutes)
            + ":" + leadingZeroSeconds + String(seconds)
    }
    
    static func fromTimeInSeconds(_ timeInSeconds: Double) -> String {
        return fromTimeInSeconds(Int(timeInSeconds))
    }
}

enum PlayerType: String {
    case Spotify
}

enum PlayerState: Int {
    case stopped
    case playing
    case paused
    case error
}
