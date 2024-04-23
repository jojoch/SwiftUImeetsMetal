//
//  DistortionEffectShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

#include <metal_stdlib>
using namespace metal;

// step 1
[[ stitchable ]] float2 waveStep1(float2 position, float2 frameSize, float spread) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nScreenCenter = (frameSize / 2) / maxSize;
    float2 directionToCenter = nPosition - nScreenCenter;
    
    float2 displacement = normalize(directionToCenter) * spread;
    return (nPosition - displacement) * maxSize;
}

// step 2
[[ stitchable ]] float2 waveStep2(float2 position, float2 frameSize, float2 touch, float spread) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;
    
    float2 displacement = normalize(directionToTouch) * spread;
    return (nPosition - displacement) * maxSize;
}

// step 3.1
[[ stitchable ]] float2 waveStep31(float2 position, float2 frameSize, float2 touch, float spread, float width) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    return float2(outerMap, outerMap);
}

// step 3.2
[[ stitchable ]] float2 waveStep32(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));

    float2 displacement = normalize(directionToTouch) * outerMap * amount;
    return (nPosition - displacement) * maxSize;
}

// step 4
[[ stitchable ]] float2 waveStep4(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(directionToTouch));
    float map = outerMap * innerMap;

    return float2(map, map);
}

// final step
[[ stitchable ]] float2 wave(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 directionToTouch = nPosition - nTouch;
    
    float outerMap = 1.0 - smoothstep(spread - width, spread, length(directionToTouch));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(directionToTouch));
    float map = outerMap * innerMap;

    float2 displacement = normalize(directionToTouch) * amount * map;
    return (nPosition - displacement) * maxSize;
}
