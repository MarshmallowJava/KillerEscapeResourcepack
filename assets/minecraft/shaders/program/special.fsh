#version 150

uniform sampler2D DiffuseSampler;
uniform float Time;

in vec2 texCoord;
in vec2 oneTexel;

out vec4 fragColor;

void main(){

    float spole = 0.1;
    float speed = 15;
    float space = 0.7;
    float y  = 0.005*sin(tan(radians(Time*360*speed + texCoord.x * 360 * 30))) + texCoord.x * spole + (1 - space) / 2;
    float y2 = 0.005*sin(tan(radians(Time*360*speed + texCoord.x * 360 * 30))) + texCoord.x * spole + 1 - (1 - space) / 2;

    if(abs(y - texCoord.y) < 0.005 || abs(y2 - texCoord.y) < 0.005){
        vec4 color = texture(DiffuseSampler, vec2(0.0));
        fragColor = vec4(color.rgb, 1.0);
    }else{
        if(texCoord.y < y || y2 < texCoord.y){
            fragColor = vec4(vec3(0.0), 1.0);
        }else{
            vec4 color = texture(DiffuseSampler, texCoord);
            if(color.a == 0.0){
                fragColor = vec4(vec3(1.0, 0.0, 0.0), 0.0);
            }else{
                fragColor = vec4(color.rgb, 1.0);
            }
        }
    }
}
