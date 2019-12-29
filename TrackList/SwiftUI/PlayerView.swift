//
//  PlayerView.swift
//  TrackList
//
//  Created by Jack Wiig on 12/19/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import SwiftUI
import AppleScriptObjC
import KingfisherSwiftUI

struct PlayerView: View {
    @ObservedObject var parentWindow: PlayerWindow
    @ObservedObject var player = WrappedAppleScriptInterface(platform: .Spotify)
    
    var body: some View {
        ZStack(alignment: Alignment.bottomLeading, content: {
            KFImage(URL(string: player.trackArtworkURL)!)
                .placeholder({
                    Text("Placeholder, replace me with an image!") // make sure this is an image
                })
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .animation(nil)
                .blur(radius: parentWindow.hovering ? 10 : 0)
                .animation(.easeInOut)
                
            ProgressBar(progress:
                CGFloat(player.playerPosition / player.trackLength),
                        progressFetchRate: player.fetchRate)
                .frame(height: 2)
            
            if parentWindow.hovering {
                VStack(alignment: .leading, content: {
                    HStack(alignment: .center, content: {
                        CircleButton(
                            image: player.playerState == .playing
                                ? "PauseIcon"
                                : "PlayIcon",
                            action: {
                                switch (self.player.playerState) {
                                case .playing:
                                    self.player.pause()
                                case .paused:
                                    self.player.play()
                                default: break
                                }
                                // Force update to refresh pause/play state immediately
                                self.player.fetchData()
                        })
                            .frame(width: 25, height: 25, alignment: .center)
                    })
                })
            }
        })
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 75, // move these to an options file later on
               idealWidth: 180,
               maxWidth: 512,
               minHeight: 75,
               idealHeight: 180,
               maxHeight: 512,
               alignment: .center)
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(parentWindow: PlayerWindow(
            contentRect: NSRect(x: 0, y: 0, width: 180, height: 180),
            styleMask: [.resizable, .fullSizeContentView],
            backing: .buffered, defer: false))
                .frame(width: 180, height: 180, alignment: .center)
    }
}
