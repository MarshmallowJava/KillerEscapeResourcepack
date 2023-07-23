#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform int FogShape;

uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;

void main() {

    vertexDistance = fog_distance(ModelViewMat, IViewRotMat * Position, FogShape);
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
    texCoord0 = UV0;

    vec4 special = texture(Sampler0, UV0);

    //差分
    vec3 delta = vec3(0.0);
    if(special.rgb == vec3(1.0, 0.0, 0.0)){
        delta.x = sin(radians(int(-fract(GameTime * 1200)*360*10) + Position.x + Position.y));
        delta.y = sin(radians(int(-fract(GameTime * 1200)*360*5) + Position.x + Position.y));
    }
    if(special.rgb == vec3(0.0, 1.0, 0.0)){
        delta.x = 1.5 * cos(radians(-fract(GameTime * 1200)*360 + Position.x + Position.y));
        delta.y = 1.5 * sin(radians(-fract(GameTime * 1200)*360 + Position.x + Position.y));
    }
    if(special.rgb == vec3(0.0, 0.0, 1.0)){
        delta.x = 3*cos(radians(-fract(GameTime * 1200)*360 + Position.y*10));
    }

    gl_Position = ProjMat * ModelViewMat * vec4(Position + delta, 1.0);
}
