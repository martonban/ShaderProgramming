#version 330

uniform vec2 uResolution;
uniform float uTime;

out vec4 outColor;

vec2 randomVector(vec2 gridCorner) {
	float x = dot(gridCorner, vec2(123.4, 234.5));
	float y = dot(gridCorner, vec2(234.5, 345.6));
	vec2 gradient = vec2(x, y);
	
	gradient = sin(gradient);
	gradient = gradient * 143758.;
	gradient = sin(gradient + uTime);
	return gradient;
}

vec2 cubic(vec2 p) {
  return p * p * (3.0 - p * 2.0);
}

vec2 quintic(vec2 p) {
  return p * p * p * (10.0 + p * (-15.0 + p * 6.0));
}


void main()
{

	vec2 uv = gl_FragCoord.xy/uResolution;
	//uv = gl_FragCoord.xy/uResolution.y;
	
	
	float grid_numbers = 4.0f;
	
	uv = uv * grid_numbers;
    vec2 gridId = floor(uv);
    vec2 gridUv = fract(uv);
   
    // Corners Coords
  	vec2 up_right_corner = gridId + vec2(1.0, 1.0);
  	vec2 up_left_corner = gridId + vec2(0.0, 1.0);
  	vec2 bottom_right_corner = gridId + vec2(1.0, 0.0);
  	vec2 bottom_left_corner = gridId + vec2(0.0, 0.0);
  	
  	// Corner's vector coords
  	vec2 up_right_vector = randomVector(up_right_corner);
  	vec2 up_left_vector = randomVector(up_left_corner);
  	vec2 bottom_right_vector = randomVector(bottom_right_corner);
  	vec2 bottom_left_vector = randomVector(bottom_left_corner);
  	
  	
  	
  	// Distance vector
  	vec2 up_right_distance = gridUv - vec2(1.0, 1.0);
  	vec2 up_left_distance = gridUv - vec2(0.0, 1.0);
  	vec2 bottom_right_distance = gridUv - vec2(1.0, 0.0);
  	vec2 bottom_left_distance = gridUv - vec2(0.0, 0.0);
  	
  	
  	float up_right_dot = dot(up_right_vector, up_right_distance);
  	float up_left_dot = dot(up_left_vector, up_left_distance);
  	float bottom_right_dot = dot(bottom_right_vector, bottom_right_distance);
  	float bottom_left_dot = dot(bottom_left_vector, bottom_left_distance);
  	

  	gridUv = quintic(gridUv);  	
  	
  	
  	float t = mix(up_left_dot, up_right_dot, gridUv.x);
  	float b = mix(bottom_left_dot, bottom_right_dot, gridUv.x);
  	float perlin = mix(b, t, gridUv.y);
	
    
    
   
   // Final Color
   vec3 final_color = vec3(perlin + 0.2);
   
   
    // Output
    outColor = vec4(final_color, 1.0f);
}