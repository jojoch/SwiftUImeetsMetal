//
//  DotsExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

import SwiftUI

struct DotsExampleView: View {
    @State private var dragLocation: CGPoint = .zero

    var body: some View {
        VStack {
            Rectangle()
                .visualEffect { content, geometryProxy in
                    content
                        .colorEffect(ShaderLibrary.dots(
                                .float2(dragLocation),
                                .float2(geometryProxy.size)
                            )
                        )
                }
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.dragLocation = gesture.location
                        }
                )
        }
    }
}

#Preview {
    DotsExampleView()
        .background(Color.black)
        .ignoresSafeArea()
}
