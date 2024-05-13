//
//  BlackAndWhiteFilterExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

import SwiftUI

struct BlackAndWhiteFilterExampleView: View {
    var body: some View {
        Image(assetImage: .header)?
            .resizable()
            .scaledToFit()
            .colorEffect(ShaderLibrary.blackAndWhite())
    }
}

#Preview {
    VStack {
        Spacer()

        BlackAndWhiteFilterExampleView()

        Spacer()
    }
    .background(Color.black)
}

