#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D SpecialSampler;

in vec2 texCoord;

out vec4 fragColor;

//p0からx軸正方向に伸ばした線がp1,p2を通る直線に交わるか判定します
int collision(vec2 p0, vec2 p1, vec2 p2){
    float dx = p2.x - p1.x;
    float dy = p2.y - p1.y;

    if(dx == 0){
        if(p0.x < p1.x){
            return 1;
        }else{
            return 0;
        }
    }
    if(dy == 0) {
        if(p0.y == p1.y){
            return 1;
        }else{
            return 0;
        }
    }

    float slope = dy / dx;
    float intercept = p1.y - slope * p1.x;
    float x = (p0.y - intercept) / slope;

    if(p0.x < x && min(p1.x, p2.x) <= x && x <= max(p1.x, p2.x)){
        return 1;
    }else{
        return 0;
    }
}

vec2 calcDelta2(vec2 pos, vec2[5] fragment){
    vec2 delta = vec2(0.0);

    int n = 0;
    n += collision(pos, fragment[1], fragment[2]);
    n += collision(pos, fragment[2], fragment[3]);
    n += collision(pos, fragment[3], fragment[4]);
    n += collision(pos, fragment[4], fragment[1]);

    if(n % 2 == 1){
        delta += fragment[0];
    }

    return delta;
}

vec2 calcDelta(vec2 pos){
    vec2 delta = vec2(0.0);

    // //fragment0
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, -0.03), vec2(0.0, 1.0), vec2(0.01, 0.9), vec2(0.5, 0.9), vec2(0.6, 1.0)));

    // //fragment1
    // delta += calcDelta2(pos, vec2[](vec2(0.02, 0.0), vec2(0.0, 0.9), vec2(0.2, 0.7), vec2(0.19, 0.45), vec2(0.0, 0.3)));

    // //fragment2
    // delta += calcDelta2(pos, vec2[](vec2(0.01, 0.0), vec2(0.2, 0.7), vec2(0.4, 0.65), vec2(0.43, 0.60), vec2(0.19, 0.45)));

    // //fragment3
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, 0.01), vec2(0.0, 0.3), vec2(0.19, 0.45), vec2(0.3, 0.4), vec2(0.32, 0.2)));
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, 0.01), vec2(0.0, 0.3), vec2(0.001, 0.2), vec2(0.2, 0.1), vec2(0.32, 0.2)));

    // //fragment3
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, 0.03), vec2(0.0, 0.0), vec2(0.0, 0.2), vec2(0.2, 0.1), vec2(0.3, 0.0)));

    // //fragment4
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, 0.00), vec2(1.0, 0.8), vec2(0.95, 0.75), vec2(0.94, 0.45), vec2(1.0, 0.2)));
    // delta += calcDelta2(pos, vec2[](vec2(-0.01, 0.01), vec2(1.0, 0.2), vec2(0.8, 0.21), vec2(0.65, 0.0), vec2(1.1, 0.0)));

delta += calcDelta2(pos, vec2[](vec2(-0.022, -0.030), vec2(0.000, 0.997), vec2(0.000, 0.866), vec2(0.385, 0.970), vec2(0.494, 1.000)));
delta += calcDelta2(pos, vec2[](vec2(-0.005, 0.030), vec2(0.001, 0.000), vec2(0.002, 0.452), vec2(0.236, 0.230), vec2(0.286, 0.003)));
delta += calcDelta2(pos, vec2[](vec2(0.033, -0.005), vec2(0.000, 0.866), vec2(0.252, 0.767), vec2(0.281, 0.523), vec2(0.002, 0.452)));
delta += calcDelta2(pos, vec2[](vec2(-0.020, 0.008), vec2(0.281, 0.523), vec2(0.002, 0.452), vec2(0.319, 0.360), vec2(0.327, 0.453)));
delta += calcDelta2(pos, vec2[](vec2(-0.028, 0.008), vec2(0.002, 0.452), vec2(0.002, 0.452), vec2(0.236, 0.230), vec2(0.319, 0.360)));
delta += calcDelta2(pos, vec2[](vec2(-0.015, -0.029), vec2(0.236, 0.230), vec2(0.319, 0.360), vec2(0.660, 0.006), vec2(0.286, 0.003)));
delta += calcDelta2(pos, vec2[](vec2(-0.025, 0.029), vec2(0.660, 0.006), vec2(0.787, 0.236), vec2(0.999, 0.241), vec2(1.000, 0.008)));
delta += calcDelta2(pos, vec2[](vec2(-0.014, 0.035), vec2(0.998, 0.995), vec2(0.938, 0.736), vec2(0.969, 0.491), vec2(0.999, 0.241)));
delta += calcDelta2(pos, vec2[](vec2(0.000, 0.000), vec2(0.787, 0.236), vec2(0.511, 0.339), vec2(0.456, 0.217), vec2(0.660, 0.006)));
delta += calcDelta2(pos, vec2[](vec2(-0.013, 0.018), vec2(0.327, 0.453), vec2(0.319, 0.360), vec2(0.456, 0.217), vec2(0.511, 0.339)));
delta += calcDelta2(pos, vec2[](vec2(0.017, 0.018), vec2(0.499, 0.505), vec2(0.327, 0.453), vec2(0.511, 0.339), vec2(0.470, 0.408)));
delta += calcDelta2(pos, vec2[](vec2(0.002, -0.030), vec2(0.511, 0.339), vec2(0.593, 0.459), vec2(0.999, 0.241), vec2(0.511, 0.339)));
delta += calcDelta2(pos, vec2[](vec2(-0.024, -0.012), vec2(0.511, 0.339), vec2(0.470, 0.408), vec2(0.499, 0.505), vec2(0.593, 0.459)));
delta += calcDelta2(pos, vec2[](vec2(-0.016, 0.003), vec2(0.000, 0.866), vec2(0.494, 1.000), vec2(0.421, 0.699), vec2(0.252, 0.767)));
delta += calcDelta2(pos, vec2[](vec2(-0.029, -0.008), vec2(0.252, 0.767), vec2(0.281, 0.523), vec2(0.281, 0.523), vec2(0.421, 0.699)));
delta += calcDelta2(pos, vec2[](vec2(0.001, -0.045), vec2(0.281, 0.523), vec2(0.327, 0.453), vec2(0.499, 0.505), vec2(0.334, 0.586)));
delta += calcDelta2(pos, vec2[](vec2(-0.019, 0.021), vec2(0.499, 0.505), vec2(0.582, 0.699), vec2(0.709, 0.608), vec2(0.698, 0.408)));
delta += calcDelta2(pos, vec2[](vec2(0.020, 0.003), vec2(0.709, 0.608), vec2(0.698, 0.408), vec2(0.999, 0.241), vec2(0.938, 0.736)));
delta += calcDelta2(pos, vec2[](vec2(0.000, 0.000), vec2(0.582, 0.699), vec2(0.709, 0.608), vec2(0.938, 0.736), vec2(0.623, 0.792)));
delta += calcDelta2(pos, vec2[](vec2(-0.002, 0.029), vec2(0.578, 0.997), vec2(0.623, 0.792), vec2(0.938, 0.736), vec2(0.998, 0.995)));
delta += calcDelta2(pos, vec2[](vec2(0.000, 0.039), vec2(0.494, 1.000), vec2(0.578, 0.997), vec2(0.623, 0.792), vec2(0.421, 0.699)));
delta += calcDelta2(pos, vec2[](vec2(0.015, -0.045), vec2(0.421, 0.699), vec2(0.623, 0.792), vec2(0.499, 0.505), vec2(0.334, 0.586)));

    delta *= max(0.0, min(1.0, texture() * 8 - 3));

    return delta;
}

void main(){
    if(texture(SpecialSampler, vec2(0.0)).rgb == vec3(1.0, 0.0, 0.0)){
    vec2 texPos = vec2(texCoord.x, texCoord.y);
    vec2 delta = calcDelta(texCoord);
    texPos += delta;

    if(0.0 <= texPos.x && texPos.x <= 1.0 && 0.0 <= texPos.y && texPos.y <= 1.0){
        vec2 delta2 = calcDelta(texPos);
        if(delta == delta2){
            fragColor = texture(DiffuseSampler, texPos);
        }else{
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
            // fragColor = vec4(cos(radians((texCoord.x + texCoord.y) * 360)) * 0.5 + 0.5, sin(radians((texCoord.x + texCoord.y) * 360)), 0.0, 1.0);
        }
    }else{
        fragColor = vec4(0.0, 0.0, 0.0, 1.0);
            // fragColor = vec4(cos(radians((texCoord.x + texCoord.y) * 360)) * 0.5 + 0.5, sin(radians((texCoord.x + texCoord.y) * 360)), 0.0, 1.0);
    }

    if(delta != vec2(0.0)){
        // fragColor = vec4(0.0, 0.0, 0.0, 1.0);
    }
    }else{

    }
}
