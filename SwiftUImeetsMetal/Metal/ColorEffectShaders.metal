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

// blending dots
[[ stitchable ]] half4 dots(float2 position, half4 color, float2 touch, float2 frameSize) {
    half4 purpleColor = half4(0.5, 0, 1, 1);
    half4 blackColor = half4(0, 0, 0, 1);

    float maxSize = max(frameSize.x, frameSize.y);
    float2 screenCenter = frameSize / 2;
    float2 nPositionToScreenCenter = (position - screenCenter) / maxSize;
    float2 nTouchToScreenCenter = (touch - screenCenter) / maxSize;

    // TODO: - Implementation

    return color;
}
