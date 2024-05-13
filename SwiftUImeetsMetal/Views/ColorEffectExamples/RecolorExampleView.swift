//
//  RecolorExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

import SwiftUI

struct RecolorExampleView: View {
    var body: some View {
        Image(assetImage: .logo)?
            .resizable()
            .scaledToFit()
            .foregroundColor(.white)
            .colorEffect(ShaderLibrary.recolor(.color(.purple)))
    }
}

#Preview {
    VStack {
        Spacer()

        RecolorExampleView()

        Spacer()
    }
    .background(Color.black)
}
