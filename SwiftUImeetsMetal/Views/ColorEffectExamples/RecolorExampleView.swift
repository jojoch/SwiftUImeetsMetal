//
//  RecolorExampleView.swift
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

import SwiftUI

struct RecolorExampleView: View {
    var body: some View {
        VStack {
            Spacer()

            Image(assetImage: .logo)?
                .resizable()
                .frame(width: 400, height: 200)
                .foregroundColor(.white)
                .colorEffect(ShaderLibrary.recolor(.color(.purple)))

            Spacer()
        }
    }
}

#Preview {
    RecolorExampleView()
        .background(Color.black)
}
