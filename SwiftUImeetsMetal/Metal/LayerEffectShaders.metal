//
//  LayerEffectShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

// pixelates layer by strength
[[ stitchable ]] half4 pixelate(float2 position, SwiftUI::Layer layer, float strength) {
    float x = strength * round(position.x / strength);
    float y = strength * round(position.y / strength);
    return layer.sample(float2(x, y));
}

// dots
[[ stitchable ]] half4 dots(float2 position, SwiftUI::Layer layer, float2 touch, float2 frameSize) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 screenCenter = frameSize / 2;
    float2 nPosition = (position - screenCenter) / maxSize;
    float2 nTouch = (touch - screenCenter) / maxSize;
        
    float cDistance = length(nPosition) * 10.0;
    float tDistance = length(nTouch - nPosition) * 20.0;
    float color = cDistance * cDistance * tDistance;
    
    if (color <= 1) {
        return half4(0.5, 0, 1, 1);
    }
    return half4(0, 0, 0, 1);
}
