#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D MarkerSampler;
uniform float Time;

in vec2 texCoord;

out vec4 fragColor;

int power2(int n){
    int result = 1;

    for(int i = 0;i < n;i++){
        result *= 2;
    }

    return result;
}

vec3[] markers = vec3[](
    vec3(0.0, 0.0, 1.0),
    vec3(0.0, 1.0, 0.0),
    vec3(0.0, 1.0, 1.0),
    vec3(1.0, 0.0, 0.0),
    vec3(1.0, 0.0, 1.0),
    vec3(1.0, 1.0, 0.0)
);

int get_special_marker(sampler2D tex){
    int result = 0;

    for(int i = 0;i < 6;i++){
        vec4 color = texture(tex, vec2(float(i) / 6.0 + 1.0 / 12.0, 0.0));

        if(color.rgb == markers[i]){
            result += power2(i);
        }
    }

    return result;
}

void main(){
    vec4 color = texture(DiffuseSampler, texCoord);

    int id = get_special_marker(MarkerSampler);

    if(id == 0){
        fragColor = color;
    }else if(id == 1){//痛い！！！
        vec4 white = vec4(1.0, 0.0, 0.0, 1.0);
        float d = min(1.0, length(texCoord - 0.5) / 2.0 * max(0.5, sin(radians(Time * 180))));
        fragColor = white * d + color * (1 - d);
    }else{
        fragColor = color;
    }

// 正しく切り替え機能が行われているか確認
    // if(id < texCoord.x * 64 && texCoord.x * 64 < id + 1 && texCoord.y > 0.5){
    //     fragColor = vec4(1.0, 0.0, 0.0, 1.0);
    // }else{
    //     fragColor = color;
    // }
}