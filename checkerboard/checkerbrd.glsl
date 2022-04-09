void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    
    const float scale = 5.0; // a higher value will give bigger squares

    // dividing the fragCoord by the scale will give us a smaller value for each component
    // flooring the smaller value will give us the same result for a larger set of pixels, thus giving a larger square
    vec2 scaled_fragCoord = floor(fragCoord/scale);
    
    // the mod function gives us the modulus (remainder) of the sum of the x component 
    // and y component of the scaled pixel coordinate by 2. The remainder will always
    // be either 1.0 or 0.0 (because we are dividing with an integer (a float here)), 
    // thus this prevents a gradient from forming.
    
    // .xxx creates a 3-component vector filled with the values of the pixel's x coordinate,
    // and we add all those values with the y component in order to perform alternating
    // colors on the Y axis as well (performing the modulus on only the .xxx components
    // would create a alternating bar pattern on the X axis)
    vec3 col = mod(scaled_fragCoord.xxx + scaled_fragCoord.y, 2.0); 
    
    fragColor = vec4(col,1.0);
}
