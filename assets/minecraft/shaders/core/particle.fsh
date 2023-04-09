#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;
in float isMarker;

out vec4 fragColor;

void main() {
    if(isMarker == 1.0){
        fragColor = vec4(vertexColor.rgb, 1.0);
    }else{
        vec4 color = texture(Sampler0, texCoord0);

        //判定用配色を修正
        if(color.rgb == vec3(1.0, 0.0, 0.0)){
            color.rgb = vec3(1.0);
        }

        color = color * vertexColor * ColorModulator;
        if (color.a < 0.1) {
            discard;
        }
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
}
