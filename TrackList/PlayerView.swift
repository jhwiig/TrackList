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
        ZStack {
            GeometryReader { windowGeometry in
                KFImage(URL(string: self.player.trackArtworkURL)!)
                    .resizable()
                    .scaledToFit()
                
                if self.parentWindow.hovering {
                    VStack {
                        Text(self.player.trackName)
                        Text(self.player.trackArtist)
                        Text(self.player.trackAlbum)
                    }
                }
            }
        }
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
            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
            backing: .buffered, defer: false))
                .frame(width: 180, height: 180, alignment: .center)
    }
}
