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
    if(currentColor.a < 0.1) {
        return currentColor.a;
    }
    return newColor;
}

// converts the view to black and white
[[ stitchable ]] half4 blackAndWhite(float2 position, half4 color) {
    float luminance = (color.r + color.g + color.b) / 3;
    return half4(luminance, luminance, luminance, 1);
}
