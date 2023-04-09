#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D LastSampler;

out vec4 fragColor;

void main(){
    vec4 color = texture(DiffuseSampler, vec2(0.0));

    if(color.rgb == vec3(0.0)){
        vec4 result = texture(LastSampler, vec2(0.0));

        result.a += 1.0 / 300.0;
        if(result.a > 1){
            result = vec4(0.0);
        }

        fragColor = result;
    }else{
        fragColor = vec4(color.rgb, 0.0);
    }
}