//
//  WaveExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

import SwiftUI

struct WaveExampleView: View {
    @State private var startDate = Date()
    @State private var location: CGPoint = .zero
    
    private let headerFrame: CGSize = .init(width: 400, height: 150)
    private let width: CGFloat = 0.06
    private let amount: CGFloat = 0.05
    private let tint: Color = .orange.opacity(0.6)

    var body: some View {
        TimelineView(.animation) { context in
            let elapsedTime = Date().timeIntervalSince(startDate)

            Image(assetImage: .header)?
                .resizable()
                .frame(width: headerFrame.width,
                       height: headerFrame.height)
                .layerEffect(
                    ShaderLibrary.waveColored(
                        .float2(headerFrame),
                        .float2(location),
                        .color(tint),
                        .float(elapsedTime),
                        .float(width),
                        .float(amount)
                    ),
                    maxSampleOffset: .zero
                )
        }
        .onTapGesture { location in
            self.startDate = Date()
            self.location = location
        }
    }
}

#Preview {
    VStack {
        Spacer()

        WaveExampleView()

        Spacer()
    }
    .background(Color.black)
    .ignoresSafeArea()
}
