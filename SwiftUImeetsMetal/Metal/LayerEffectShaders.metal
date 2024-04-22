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

    // TODO: - Implementation

    return layer.sample(position);
}

// blending dots
[[ stitchable ]] half4 dots(float2 position, SwiftUI::Layer layer, float2 touch, float2 frameSize) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 screenCenter = frameSize / 2;
    float2 nPosition = (position - screenCenter) / maxSize;
    float2 nTouch = (touch - screenCenter) / maxSize;
    
    // TODO: - Implementation

    return layer.sample(position);
}
