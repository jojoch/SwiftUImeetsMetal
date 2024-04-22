//
//  ColorEffectShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 18.04.2024.
//

#include <metal_stdlib>
using namespace metal;

// recolors non-transparent pixels
[[ stitchable ]] half4 recolor(float2 position, half4 currentColor, half4 newColor) {

    // TODO: - Implementation

    return currentColor;
}

// converts the view to black and white
[[ stitchable ]] half4 blackAndWhite(float2 position, half4 color) {

    // TODO: - Implementation

    return color;
}
