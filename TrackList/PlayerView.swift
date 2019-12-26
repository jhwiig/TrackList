//
//  PlayerView.swift
//  TrackList
//
//  Created by Jack Wiig on 12/19/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import SwiftUI
import AppleScriptObjC

struct PlayerView: View {
    @ObservedObject var parentWindow: PlayerWindow
    @ObservedObject var player = WrappedAppleScriptInterface(platform: .Spotify)
    
    var body: some View {
        ZStack {
            GeometryReader { windowGeometry in
                Text("Open Spotify to View Track")
                    .frame(width: windowGeometry.size.width,
                           height: windowGeometry.size.height,
                           alignment: .center)
                
                if self.parentWindow.hovering {
                    VStack {
                        Text(self.player.trackName)
                        Text(self.player.trackArtist)
                        Text(self.player.trackAlbum)
                        Text(TimestampFormatter.fromTimeInSeconds(self.player.playerPosition))
                    }
                }
            }
        }
        .border(Color.green)
        .edgesIgnoringSafeArea(.all)
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
