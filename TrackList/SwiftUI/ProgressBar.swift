//
//  ProgressBar.swift
//  TrackList
//
//  Created by Jack Wiig on 12/26/19.
//  Copyright © 2019 Jack Wiig. All rights reserved.
//

import SwiftUI

// TODO: Fix Progress Bar Scaling on Resize

struct ProgressBar: View {
    @EnvironmentObject var player: WrappedAppleScriptInterface
    var progress: CGFloat
    var progressFetchRate: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottomLeading, content: {
                Rectangle()
                    .fill(Color(NSColor.lightGray))
                Rectangle()
                    .fill(Color(NSColor.textBackgroundColor))
                    .frame(width: max(min(self.progress, 1), 0) * geometry.size.width)
                    .animation(.linear(duration: self.progressFetchRate))
            })
            .drawingGroup()
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(progress: 0.25, progressFetchRate: 1)
            .frame(width: 180, height: 25, alignment: .center)
    }
}
