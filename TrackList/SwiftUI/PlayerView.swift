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
    @EnvironmentObject var player: WrappedAppleScriptInterface
    @EnvironmentObject var window: PlayerWindow
    
    var body: some View {
        ZStack(alignment: .bottomLeading, content: {
            KFImage(URL(string: player.trackArtworkURL)!)
                .placeholder({
                    Text("Placeholder, replace me with an image!") // make sure this is an image
                })
                .interpolation(.high)
                .resizable()
                .scaledToFit()
                .animation(nil)
                .blur(radius: window.hovering ? 10 : 0)
                .animation(.easeInOut)
            
            if window.hovering {
                PlayerControls()
            }
            else {
                ProgressBar(progress: CGFloat(player.playerPosition / player.trackLength),
                            progressFetchRate: player.fetchRate)
                    .frame(height: 2)
            }
        })
        .edgesIgnoringSafeArea(.all)
        .frame(minWidth: 128, // move these to an options file later on
               idealWidth: 180,
               maxWidth: 512,
               minHeight: 128,
               idealHeight: 180,
               maxHeight: 512,
               alignment: .center)
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
