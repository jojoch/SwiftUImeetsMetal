//
//  PixelateExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

import SwiftUI

struct PixelateExampleView: View {
    let startDate = Date()

    var body: some View {
        TimelineView(.animation) { context in
            let elapsedTime = Date().timeIntervalSince(startDate)

            Image(assetImage: .header)?
                .resizable()
                .scaledToFit()
                .distortionEffect(
                    ShaderLibrary.pixelate(.float(elapsedTime)),
                    maxSampleOffset: .zero
                )
        }
    }
}

#Preview {
    VStack {
        Spacer()

        PixelateExampleView()
        
        Spacer()
    }
    .background(Color.black)
    .ignoresSafeArea()
}
