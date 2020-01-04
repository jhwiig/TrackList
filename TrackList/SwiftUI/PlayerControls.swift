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
        GeometryReader { geometry in
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
                        
                        if self.player.shufflingEnabled && geometry.size.width < 200 {
                            CircleButton(
                                image: self.player.shuffling ? "ShuffleOnIcon" : "ShuffleOffIcon",
                                action: {
                                    self.player.shuffling.toggle()
                            })
                                .frame(width: 20, height: 20, alignment: .center)

                            Spacer()
                                .frame(width: 5)
                            
                            CircleButton(
                                image: self.player.repeating ? "RepeatOnIcon" : "RepeatOffIcon",
                                action: {
                                    self.player.repeating.toggle()
                            })
                                .frame(width: 20, height: 20, alignment: .center)

                            Spacer()
                        }
                        
                        CircleButton(image: "SettingsIcon", action: {
                            //
                        })
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                    
                    Spacer()
                    
                    HStack {
                        CustomSlider(value:
                            Binding<Double>(get: { Double(self.player.volume) },
                                            set: { newVolume in self.player.volume = Int(newVolume) }),
                                     maxValue: 100)
                            .frame(height: 8)
                            .frame(maxWidth: 250)
                    }
                    
                    HStack(alignment: .center, content: {
                        
                        if self.player.shufflingEnabled && geometry.size.width >= 200 {
                            CircleButton(
                                image: self.player.shuffling ? "ShuffleOnIcon" : "ShuffleOffIcon",
                                action: {
                                    self.player.shuffling.toggle()
                            })
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                        
                        CircleButton(image: "PreviousIcon", action: {
                            self.player.previous()
                        })
                            .frame(width: 25, height: 25, alignment: .center)
                        
                        CircleButton(
                            image: self.player.playerState == .playing ? "PauseIcon" : "PlayIcon",
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
                        
                        if self.player.shufflingEnabled && geometry.size.width >= 200 {
                            CircleButton(
                                image: self.player.repeating ? "RepeatOnIcon" : "RepeatOffIcon",
                                action: {
                                    self.player.repeating.toggle()
                            })
                                .frame(width: 20, height: 20, alignment: .center)
                        }
                    })
                    
                    VStack(spacing: 0, content: {
                        CustomSlider(value: self.$player.playerPosition, maxValue: self.player.trackLength)
                            .frame(height: 8)
                        
                        HStack {
                            Text(TimestampFormatter.fromTimeInSeconds(self.player.playerPosition))
                                .shadow(color: Color(NSColor.textBackgroundColor), radius: 5)
                                .fixedSize()
                                .padding(.leading, 4)

                            Spacer()
                            Text(TimestampFormatter.fromTimeInSeconds(self.player.trackLength))
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
}

struct PlayerControls_Previews: PreviewProvider {
    static var previews: some View {
        PlayerControls()
            .frame(width: 180, height: 180, alignment: .center)
    }
}
