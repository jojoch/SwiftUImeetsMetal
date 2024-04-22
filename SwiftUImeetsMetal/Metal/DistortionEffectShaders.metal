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
    float2 nScreenCenter = float2(0.5, frameSize.y / frameSize.x); // the image is wider
    float2 distance = nPosition - nScreenCenter;
    
    float2 displacement = normalize(distance) * spread;
    return (nPosition - displacement) * maxSize;
}

// step 2
[[ stitchable ]] float2 waveStep2(float2 position, float2 frameSize, float2 touch, float spread) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 distance = nPosition - nTouch;
    
    float2 displacement = normalize(distance) * spread;
    return (nPosition - displacement) * maxSize;
}

// step 3.1
[[ stitchable ]] float2 waveStep31(float2 position, float2 frameSize, float2 touch, float spread, float width) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 distance = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(distance));
    return float2(outerMap, outerMap);
}

// step 3.2
[[ stitchable ]] float2 waveStep32(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 distance = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(distance));

    float2 displacement = normalize(distance) * outerMap * amount;
    return (nPosition - displacement) * maxSize;
}

// step 4
[[ stitchable ]] float2 waveStep4(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 distance = nPosition - nTouch;

    float outerMap = 1.0 - smoothstep(spread - width, spread, length(distance));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(distance));
    float map = outerMap * innerMap;

    return float2(map, map);
}

// final step
[[ stitchable ]] float2 wave(float2 position, float2 frameSize, float2 touch, float spread, float width, float amount) {
    float maxSize = max(frameSize.x, frameSize.y);
    float2 nPosition = position / maxSize;
    float2 nTouch = touch / maxSize;
    float2 distance = nPosition - nTouch;
    
    float outerMap = 1.0 - smoothstep(spread - width, spread, length(distance));
    float innerMap = smoothstep(spread - (width * 2.0), spread - width, length(distance));
    float map = outerMap * innerMap;

    float2 displacement = normalize(distance) * amount * map;
    return (nPosition - displacement) * maxSize;
}
