//
//  BlackAndWhiteFilterExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

import SwiftUI

struct BlackAndWhiteFilterExampleView: View {
    var body: some View {
        VStack {
            Spacer()

            Image(assetImage: .header)?
                .resizable()
                .frame(width: 400, height: 150)
                .colorEffect(ShaderLibrary.blackAndWhite())

            Spacer()
        }
    }
}

#Preview {
    BlackAndWhiteFilterExampleView()
        .background(Color.black)
}

