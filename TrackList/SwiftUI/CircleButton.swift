//
//  CircleButton.swift
//  TrackList
//
//  Created by Jack Wiig on 12/28/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import SwiftUI

struct CircleButton: View {
    var image: String
    var action: () -> Void
    @State private var hovering: Bool = false
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Circle()
                    .fill(Color.gray)
                    .blendMode(.screen)
                    .animation(.easeInOut(duration: 0.1))
                    .onHover(perform: { hovering in
                        self.hovering = hovering
                    })
                
                GeometryReader { geometry in
                    Image(self.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width * 0.6,
                               height: geometry.size.height * 0.6,
                               alignment: .center)
                }
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(image: "", action: {})
            .frame(width: 50, height: 50, alignment: .center)
    }
}
