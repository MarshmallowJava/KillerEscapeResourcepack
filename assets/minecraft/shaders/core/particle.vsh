#version 150

#moj_import <fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;
out float isMarker;

vec2[] corners = vec2[](
    vec2(0, 1),
    vec2(0, 0),
    vec2(1, 0),
    vec2(1, 1)
);

void main() {
    float min = min(min(Color.r, Color.g), Color.b);
    float max = max(max(Color.r, Color.g), Color.b);

    if(min != max && int(Color.r) == Color.r && int(Color.g) == Color.g && int(Color.b) == Color.b){
        int id = gl_VertexID % 4;
        gl_Position = vec4(0.001*corners[id] - 1.0, 0.0, 1.0);
        isMarker = 1.0;
    }else{
        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
        isMarker = 0.0;
    }

    texCoord0 = UV0;
    vertexDistance = fog_distance(ModelViewMat, Position, FogShape);
    vertexColor = Color;
}
