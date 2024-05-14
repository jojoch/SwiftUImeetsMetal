//
//  DistortionEffectShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 19.04.2024.
//

#include <metal_stdlib>
using namespace metal;

// pixelates layer by strength
[[ stitchable ]] float2 pixelate(float2 position, float strength) {
    float positionX = strength * floor(position.x / strength);
    float positionY = strength * floor(position.y / strength);

    return float2(positionX, positionY);
}

// TODO: - transition
