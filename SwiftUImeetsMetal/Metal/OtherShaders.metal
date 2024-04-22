//
//  OtherShaders.metal
//  SwiftUImeetsMetal
//
//  Created by Veronika Zelinkova on 20.04.2024.
//

#include <metal_stdlib>
using namespace metal;

// abstract pink texture
// https://www.shadertoy.com/view/ftSSRR
float colormapRed(float x) {
    if (x < 0.0) {
        return 54.0 / 255.0;
    } else if (x < 20049.0 / 82979.0) {
        return (829.79 * x + 54.51) / 255.0;
    } else {
        return 1.0;
    }
}

float colormapGreen(float x) {
    if (x < 20049.0 / 82979.0) {
        return 0.0;
    } else if (x < 327013.0 / 810990.0) {
        return (8546482679670.0 / 10875673217.0 * x - 2064961390770.0 / 10875673217.0) / 255.0;
    } else if (x <= 1.0) {
        return (103806720.0 / 483977.0 * x + 19607415.0 / 483977.0) / 255.0;
    } else {
        return 1.0;
    }
}

float colormapBlue(float x) {
    if (x < 0.0) {
        return 54.0 / 255.0;
    } else if (x < 7249.0 / 82979.0) {
        return (829.79 * x + 54.51) / 255.0;
    } else if (x < 20049.0 / 82979.0) {
        return 127.0 / 255.0;
    } else if (x < 327013.0 / 810990.0) {
        return (792.02249341361393720147485376583 * x - 64.364790735602331034989206222672) / 255.0;
    } else {
        return 1.0;
    }
}

float4 colormap(float x) {
    return float4(colormapRed(x), colormapGreen(x), colormapBlue(x), 1.0);
}

float rand(float2 n) {
    return fract(sin(dot(n, float2(12.9898, 4.1414))) * 43758.5453);
}

float noise(float2 p){
    float2 ip = floor(p);
    float2 u = fract(p);
    u = u*u*(3.0-2.0*u);

    float res = mix(
        mix(rand(ip),rand(ip+float2(1.0,0.0)),u.x),
        mix(rand(ip+float2(0.0,1.0)),rand(ip+float2(1.0,1.0)),u.x),u.y);
    return res*res;
}

float fbm(float2 p, float iTime)
{
    const float2 mtx0 = float2(0.80, 0.60);
    const float2 mtx1 = float2(-0.60, 0.80);
    float f = 0.0;

    f += 0.500000 * noise(p + iTime); p = mtx0 * p * 2.02 + mtx1 * p * 2.02;
    f += 0.031250 * noise(p); p = mtx0 * p * 2.01 + mtx1 * p * 2.01;
    f += 0.250000 * noise(p); p = mtx0 * p * 2.03 + mtx1 * p * 2.03;
    f += 0.125000 * noise(p); p = mtx0 * p * 2.01 + mtx1 * p * 2.01;
    f += 0.062500 * noise(p); p = mtx0 * p * 2.04 + mtx1 * p * 2.04;
    f += 0.015625 * noise(p + sin(iTime));

    return f / 0.96875;
}

float pattern(float2 p, float iTime)
{
    return fbm(p + fbm(p + fbm(p, iTime), iTime), iTime);
}

[[ stitchable ]] half4 pinkTexture(float2 position, half4 currentColor, float time) {
    // TODO - use correct frame size if preffered
    float2 uv = position / float2(400, 800);
    float shade = pattern(uv, time);
    float3 result = colormap(shade).rgb;
    return half4(result.x, result.y, result.z, 1-shade);
}
