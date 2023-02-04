#define WIDTH_MODF 20.0

vec3 lum(float colorFactor, vec3 rgb) {
    vec3 lum = vec3(0.21, 0.71, 0.07);
    float grey = dot(rgb, lum);
    
    return mix(vec3(grey), rgb, colorFactor);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    vec2 uv = fragCoord/iResolution.xy;
    
    vec2 source = vec2(0.5, 1.0);
    vec2 wind_vector = vec2(0.0, -1.0);

    // cosine-inverse method
    float angle = degrees(acos(dot(uv-source, wind_vector)/length(uv-source)*length(wind_vector)));
    float xDeriv = cos(radians(angle)) * length(uv-source);
    
    
    float change = iTime;
    vec3 col = mix(
                mix(
                
                 vec3(0.99, 0.75, 0.0), 
                 lum(0.0, texture(iChannel0, uv + wind_vector * -iTime).rgb), 
                 xDeriv),
                 
                vec3(0.0),
                angle/10.0);
                
    col = mix(col, vec3(0.0), step(90.0, angle));
    
    float emission = 10.0;
    float offset = 10.0;
    
    // sigmoid
    col = mix(col, vec3(0.0), 1.0/(1.0 + offset*exp(-emission*length(uv-source)/2.5)));
    
    fragColor = vec4(col,1.0);
}
