//
//  AbstractTextureExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 20.04.2024.
//

import SwiftUI

struct AbstractTextureExampleView: View {
    @State private var startDate = Date()

    var body: some View {
        VStack {
            TimelineView(.animation) { context in
                let elapsedTime = Date().timeIntervalSince(startDate)

                Rectangle()
                    .colorEffect(
                        ShaderLibrary.pinkTexture(.float(elapsedTime))
                    )
            }
        }
    }
}

#Preview {
    AbstractTextureExampleView()
        .background(Color.black)
        .ignoresSafeArea()
}
