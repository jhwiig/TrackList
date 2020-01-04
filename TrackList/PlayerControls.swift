//
//  PlayerControls.swift
//  TrackList
//
//  Created by Jack Wiig on 1/1/20.
//  Copyright © 2020 Jack Wiig. All rights reserved.
//

import SwiftUI

struct PlayerControls: View {
    @EnvironmentObject var player: WrappedAppleScriptInterface
    @EnvironmentObject var window: PlayerWindow
    
    var body: some View {
        HStack {
            Spacer()
                .frame(width: 5)
            VStack {
                Spacer()
                    .frame(height: 5)
                
                HStack {
                    CircleButton(image: "CloseIcon", action: {
                        self.window.close()
                    })
                        .frame(width: 20, height: 20, alignment: .center)
                                
                    Spacer()
                                
                    CircleButton(image: "SettingsIcon", action: {
                        self.player.focus()
                    })
                        .frame(width: 20, height: 20, alignment: .center)
                }

                Spacer()
                
                VStack {
                    Text(player.trackName)
                        .font(.system(size: 14))
                        .fontWeight(.bold)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(NSColor.textBackgroundColor), radius: 10)
                        .layoutPriority(3)
                        
                    Text(player.trackArtist)
                        .truncationMode(.tail)
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(NSColor.textBackgroundColor), radius: 10)
                        .padding(.bottom, 2)
                        .layoutPriority(2)
                    
                    Text(player.trackAlbum)
                        .font(.system(size: 10))
                        .truncationMode(.tail)
                        .multilineTextAlignment(.center)
                        .shadow(color: Color(NSColor.textBackgroundColor), radius: 10)
                        .layoutPriority(1)
                }
                
                VStack(spacing: 0, content: {
                    HStack {
                        Image("VolumeLowIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 10)
                            .padding(.leading, 4)
                        Spacer()
                        Image("VolumeHighIcon")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 10)
                            .padding(.trailing, 4)
                    }
                    CustomSlider(value:
                        Binding<Double>(get: { Double(self.player.volume) },
                                        set: { newVolume in self.player.volume = Int(newVolume) }),
                                 maxValue: 100)
                        .frame(height: 8)
                })
                    .frame(maxWidth: 250)

                HStack {
                    if player.shufflingEnabled {
                        CircleButton(
                            image: player.shuffling ? "ShuffleOnIcon" : "ShuffleOffIcon",
                            action: {
                                self.player.shuffling.toggle()
                                self.player.fetchData()
                        })
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                    
                    CircleButton(image: "PreviousIcon", action: {
                        self.player.previous()
                    })
                        .frame(width: 25, height: 25, alignment: .center)
                    
                    CircleButton(
                        image: player.playerState == .playing ? "PauseIcon" : "PlayIcon",
                        action: {
                            self.player.togglePlayback()
                            // Force update to refresh pause/play state immediately
                            self.player.fetchData()
                    })
                        .frame(width: 40, height: 40, alignment: .center)
                    
                    CircleButton(image: "NextIcon", action: {
                        self.player.next()
                    })
                        .frame(width: 25, height: 25, alignment: .center)
                    
                    if player.shufflingEnabled {
                        CircleButton(
                            image: player.repeating ? "RepeatOnIcon" : "RepeatOffIcon",
                            action: {
                                self.player.repeating.toggle()
                                self.player.fetchData()
                        })
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }

                VStack(spacing: 0, content: {
                    CustomSlider(value: $player.playerPosition, maxValue: player.trackLength)
                        .frame(height: 8)
                    
                    HStack {
                        Text(TimestampFormatter.fromTimeInSeconds(player.playerPosition))
                            .shadow(color: Color(NSColor.textBackgroundColor), radius: 5)
                            .fixedSize()
                            .padding(.leading, 4)

                        Spacer()
                        Text(TimestampFormatter.fromTimeInSeconds(player.trackLength))
                            .shadow(color: Color(NSColor.textBackgroundColor), radius: 5)
                            .fixedSize()
                            .padding(.trailing, 4)
                    }
                })
                    .frame(maxWidth: 250)
                
                Spacer()
                    .frame(height: 5)
            }
            Spacer()
                .frame(width: 5)
        }
    }
}

struct PlayerControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls()
            .environmentObject(WrappedAppleScriptInterface(platform: .Spotify))
            .frame(width: 195, height: 195)
    }
}
