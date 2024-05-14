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
        return currentColor;
    }
    return newColor;
}

// converts the view to black and white
[[ stitchable ]] half4 blackAndWhite(float2 position, half4 color) {
    float luminance = (color.r + color.g + color.b) / 3;
    return half4(luminance, luminance, luminance, 1);
}

// blending dots
[[ stitchable ]] half4 dots(float2 position, half4 color, float2 touch, float2 frameSize) {
    half4 purpleColor = half4(0.5, 0, 1, 1);
    half4 blackColor = half4(0, 0, 0, 1);

    float maxSize = max(frameSize.x, frameSize.y);
    float2 screenCenter = frameSize / 2;
    
    float2 nPositionToCenter = (position - screenCenter) / maxSize;
    float cDistance = length(nPositionToCenter) * 10;
    
    float2 nTouchToCenter = nPositionToCenter - ((touch - screenCenter) / maxSize);
    float tDistance = length(nTouchToCenter) * 20;
    
    float newColor = cDistance * cDistance * tDistance;
    
    if (newColor <= 1) {
        return  purpleColor;
    }

    return blackColor;
}
