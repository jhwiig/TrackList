//
//  CustomSlider.swift
//  TrackList
//
//  Created by Jack Wiig on 1/1/20.
//  Copyright © 2020 Jack Wiig. All rights reserved.
//

import SwiftUI

struct CustomSlider: View {
    @EnvironmentObject var player: WrappedAppleScriptInterface
    @EnvironmentObject var window: PlayerWindow
    @Binding var value: Double
    var maxValue: Double
    @State private var hovering: Bool = false
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center, content: {
                ZStack(alignment: .bottomLeading, content: {
                    Rectangle()
                        .fill(Color(NSColor.lightGray))
                    Rectangle()
                        .fill(Color(NSColor.textBackgroundColor))
                        .frame(width:
                            max(min(CGFloat(self.value / self.maxValue), 1), 0)
                                * (geometry.size.width - geometry.size.height))
                })
                    .frame(width: geometry.size.width - geometry.size.height,
                           height: geometry.size.height / 5)
                
                HStack(alignment: .center, spacing: 0, content: {
                    Spacer()
                        .frame(width:
                            max(min(CGFloat(self.value / self.maxValue), 1), 0) * (geometry.size.width - geometry.size.height))
                    Circle()
                        .foregroundColor(Color(NSColor.textColor))
                        .frame(width: geometry.size.height, alignment: .center)
                    Spacer()
                })
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            })
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .onHover(perform: {hovering in
                    self.hovering = hovering
                    
                    // This is a workaround that allows moving the slider without moving the window background,
                    // but the window must be focused for it to work, so it is not a complete solution.
                    // Thanks Andrew!
                    self.window.isMovableByWindowBackground = !hovering
                })
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ dragValue in
                        self.value = Double(dragValue.location.x / geometry.size.width) * self.maxValue
                        // Fetch new value so that the slider updates quickly.
                        self.player.fetchData()
                    }))
        }
            .drawingGroup()
    }
}

struct CustomSlider_Previews: PreviewProvider {
    static var previews: some View {
        CustomSlider(value: .constant(50), maxValue: 100)
            .frame(width: 60, height: 10, alignment: .center)
    }
}
