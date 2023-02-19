#define EDGE_SCALE_FACTOR 8.0


vec3 computeMain(vec2 uv) {

    float r = length(uv-vec2(0.5, 0.5));
    
    vec3 col = mix(vec3(1.0, 0.4, 0.0), vec3(1.0, 0.4, 0.0)/2.0, r * abs(r-0.4)/r * 2.0);
    
    col = mix(texture(iChannel0, uv + vec2(iTime, 0.0)/20.0).rgb, col, 0.8);
    col = mix(mix(vec3(1.0, 0.5, 0.0),vec3(0.0),(r-0.4)/0.05), col, step(r, 0.4));
    
    return col;

}

vec3 convolute(mat3 kernel, vec2 fragCoord) {

    vec2 uv = fragCoord/iResolution.xy;
    
    vec3 tLeft = kernel[0][0] * computeMain((fragCoord + vec2(-1,1))/iResolution.xy);
    vec3 tMiddle = kernel[1][0] * computeMain((fragCoord + vec2(0,1))/iResolution.xy);
    vec3 tRight = kernel[2][0] * computeMain((fragCoord + vec2(1,1))/iResolution.xy);
    
    vec3 cLeft = kernel[0][1] * computeMain((fragCoord + vec2(-1,0))/iResolution.xy);
    vec3 cMiddle = kernel[1][1] * computeMain(fragCoord/iResolution.xy);
    vec3 cRight = kernel[2][1] * computeMain((fragCoord + vec2(1,0))/iResolution.xy);
    
    vec3 bLeft = kernel[0][2] * computeMain((fragCoord + vec2(-1,-1))/iResolution.xy);
    vec3 bMiddle = kernel[1][2] * computeMain((fragCoord + vec2(0,-1))/iResolution.xy);
    vec3 bRight = kernel[2][2] * computeMain((fragCoord + vec2(1,-1))/iResolution.xy);
    
    return tLeft + tMiddle + tRight + cLeft + cMiddle + cRight + bLeft + bMiddle + bRight;
    
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord/iResolution.xy;
    
    mat3 sobelKernel;

    sobelKernel[0] = vec3(0.0, -1.0, 0.0);
    sobelKernel[1] = vec3(-1.0, 4.0, -1.0);
    sobelKernel[2] = vec3(0.0, -1.0, 0.0);

    vec3 col = computeMain(uv);
    vec3 sobel_col = convolute(identityKernel, fragCoord) * EDGE_SCALE_FACTOR;

    fragColor = vec4(col,1.0);
}
