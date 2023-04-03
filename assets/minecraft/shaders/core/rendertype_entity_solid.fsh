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
    //白シュルカーかどうか判定
    vec2 coord = vec2((texCoord0.x * 256 - 48) / 24, (texCoord0.y * 256 - 232) / 24);
    if(texture(Sampler0, vec2(0.0)).rgb == vec3(1.0, 0.0, 0.0)){
        discard;
    }else{
        vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
        color.rgb = mix(overlayColor.rgb, color.rgb, overlayColor.a);
        color *= lightMapColor;
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
}
