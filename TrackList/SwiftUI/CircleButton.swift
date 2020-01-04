//
//  CircleButton.swift
//  TrackList
//
//  Created by Jack Wiig on 12/28/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import SwiftUI

// BUG? : While the click hitbox is a circle, the entire rectangular frame is not considered background,
//        meaning that you cannot drag the window from the edges of the button

struct CircleButton: View {
    var image: String
    var action: () -> Void
    
    var body: some View {
        GeometryReader { buttonGeometry in
            Button(action: self.action) {
                ZStack {
                    Circle()
                        .foregroundColor(Color(NSColor.textBackgroundColor))
                        .blendMode(.luminosity)
                        .animation(.easeInOut(duration: 0.1))
                        .frame(width: buttonGeometry.size.width, height: buttonGeometry.size.height)
                    
                    GeometryReader { geometry in
                        Image(self.image)
                            .interpolation(.high)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width * 0.6,
                                   height: geometry.size.height * 0.6,
                                   alignment: .center)
                    }
                }
            }
                .buttonStyle(BorderlessButtonStyle())
                .contentShape(Circle())
                .foregroundColor(Color(NSColor.textColor))
        }
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(image: "PlayIcon", action: {})
            .frame(width: 50, height: 50, alignment: .center)
    }
}
