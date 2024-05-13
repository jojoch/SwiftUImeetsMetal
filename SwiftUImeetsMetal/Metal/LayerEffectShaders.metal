//
//  LayerEffectShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

#include <metal_stdlib>
#include <SwiftUI/SwiftUI.h>
using namespace metal;

// step 1
[[ stitchable ]] half4 waveStep1(float2 position, SwiftUI::Layer layer, float2 frameSize, float spread) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nScreenCenter = (frameSize / 2) / maxSize;
    float2 directionToCenter = nPosition - nScreenCenter;
    
    float2 displacement = normalize(directionToCenter) * spread;
    float2 displacementPosition = (nPosition - displacement) * maxSize;
    return layer.sample(displacementPosition);
}

// step 2
[[ stitchable ]] half4 waveStep2(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch, float spread) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;
    
    float2 displacement = normalize(directionToTouch) * spread;
    float2 displacementPosition = (nPosition - displacement) * maxSize;
    return layer.sample(displacementPosition);
}

// step 3.1
[[ stitchable ]] half4 waveStep31(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch, float spread, float width) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    return layer.sample(float2(outerMap, outerMap));
}

// step 3.2
[[ stitchable ]] half4 waveStep32(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float2 displacement = normalize(directionToTouch) * outerMap * amount;
    float2 displacementPosition = (nPosition - displacement) * maxSize;
    return layer.sample(displacementPosition);
}

// step 4
[[ stitchable ]] half4 waveStep4(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(directionToTouch));
    float map = outerMap * innerMap;
    return layer.sample(float2(map, map));
}

// final step
[[ stitchable ]] half4 wave(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;
    
    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(directionToTouch));
    float map = outerMap * innerMap;

    float2 displacement = normalize(directionToTouch) * amount * map;
    float2 displacementPosition = (nPosition - displacement) * maxSize;
    return layer.sample(displacementPosition);
}

// wave shader with tint
[[ stitchable ]] half4 waveColored(float2 position, SwiftUI::Layer layer, float2 frameSize, float2 touch,
                                   half4 tint, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;
    
    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(directionToTouch));
    float map = outerMap * innerMap;

    float2 displacement = normalize(directionToTouch) * amount * map;
    float2 displacementPosition = (nPosition - displacement) * maxSize;
    return layer.sample(displacementPosition) + map * tint;
}
