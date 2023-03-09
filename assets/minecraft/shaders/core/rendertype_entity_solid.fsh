#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {

//    float x = texCoord0.x * 8
    if(0 <= texCoord0.x && texCoord0.x < 192.0 / 512.0 && (256.0-64.0) / 256.0 <= texCoord0.y && texCoord0.y < 1){
        discard;
    }else{
        vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
        color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
        color *= lightMapColor;
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
}
