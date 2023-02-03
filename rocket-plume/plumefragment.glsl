#define WIDTH_MODF 20.0

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    vec2 uv = fragCoord/iResolution.xy;
    
    vec2 source = vec2(0.5, 1.0);
    vec2 wind_vector = vec2(0.0, -1.0);

    // cosine-inverse method
    float angle = degrees(acos(dot(uv-source, wind_vector)/length(uv-source)*length(wind_vector)));
    float xDeriv = cos(radians(angle)) * length(uv-source);
    
    vec3 col = mix(mix(vec3(0.99, 0.75, 0.0), vec3(1.0), xDeriv), vec3(0.0), angle/WIDTH_MODF);
    
    fragColor = vec4(col,1.0);
}
