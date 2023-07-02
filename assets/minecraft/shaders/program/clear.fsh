#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    if(texCoord.y < 0.01 / 2){
        fragColor = vec4(0.0);
    }else{
        fragColor = texture(DiffuseSampler, texCoord);
    }
}