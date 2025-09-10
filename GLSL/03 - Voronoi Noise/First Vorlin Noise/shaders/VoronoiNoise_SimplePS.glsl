#version 330

uniform vec2 uResolution;
uniform float uTime;

out vec4 outColor;

vec2 noise2x2 (vec2 vector) {
	float x = dot(vector, vec2(123.4, 234.5));
	float y = dot(vector, vec2(234.5, 345.6));
	vec2 gradient = vec2(x, y);
	
	gradient = sin(gradient);
	gradient = gradient * 143758.;
	gradient = sin(gradient);
	return gradient;
}


void main()
{
    vec2 uv = gl_FragCoord.xy/uResolution;
    uv =  gl_FragCoord.xy / uResolution.y;
    
    uv = uv * 4.0f;
    vec2 gridUv = fract(uv);
    vec2 gridId = floor(uv);
    
    // Make it to the center
    gridUv = gridUv - 0.5f;
    
    
    float min_distance_from_pixel = 100.f;
    vec3 final_color = vec3(gridUv, 1.0f);
    
    for(float i = -1.0f; i <= 1.0f; i++) {
    	for(float j = -1.0f; j <= 1.0f; j++) {
    		vec2 grid_coords = vec2(i, j);
    		vec2 point_on_grid_coord = grid_coords;
    		
    		point_on_grid_coord = grid_coords + sin(uTime) * 0.5;
    		vec2 noise = noise2x2(gridId + grid_coords);
    		point_on_grid_coord = grid_coords + sin(uTime * noise) * 0.5;
    		
    		float distance = length(gridUv - point_on_grid_coord);
    		min_distance_from_pixel = min(distance, min_distance_from_pixel);
    	}
    }
    final_color = vec3(min_distance_from_pixel);
    
    outColor = vec4(final_color, 1.0);
}