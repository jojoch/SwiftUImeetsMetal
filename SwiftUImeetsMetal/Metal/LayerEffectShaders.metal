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
