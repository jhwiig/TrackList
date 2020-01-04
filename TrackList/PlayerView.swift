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
                    Image("Placeholder")
                        .resizable()
                        .scaledToFit()
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
        .frame(minWidth: 195, // move these to an options file later on
               idealWidth: 200,
               maxWidth: 480,
               minHeight: 195,
               idealHeight: 200,
               maxHeight: 480,
               alignment: .center)
    }
}


struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
    }
}
