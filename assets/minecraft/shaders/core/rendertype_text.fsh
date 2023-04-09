#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    vec4 vertex = vec4(vertexColor);
    if (color.a < 0.1) {
        discard;
    }else{
        vec3 cast = color.rgb;

        color.rgb = vec3(1.0);
        if(cast == vec3(1.0, 0.0, 0.0)){
        }
    }
    color *= vertex * ColorModulator;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
