#version 150

uniform sampler2D DiffuseSampler;

in vec2 texCoord;

out vec4 fragColor;

void main(){
    if(texCoord.x < 0.6 && 0.5 < texCoord.y){
        vec4 color = texture(DiffuseSampler, texCoord);
        if(color == vec4(1.0, 0.0, 0.0, 1.0)){
            fragColor = vec4(0.0);
        }else{
            fragColor = color;
        }
    }else{
        fragColor = texture(DiffuseSampler, texCoord);
    }
}