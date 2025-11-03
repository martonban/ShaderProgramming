#version 330
#define MAX_STEPS 100
#define MAY_DISTANCE 100.
#define THRESHOLD_DISTANCE .01

uniform vec2 uResolution;
uniform float uTime;

out vec4 outColor;

float GetDistance (vec3 point) {
	vec4 sphere = vec4(0, 1, 6, 1);
	float sphere_distance = length(point - sphere.xyz) - sphere.w;
	float plane_distance = point.y;
	return min(sphere_distance, plane_distance);
}


float RayMarching (vec3 camera_pos, vec3 ray_direction) {
	float distance_from_origin = 0.f;
	
	// LOOP
	for(int i = 0; i < MAX_STEPS; i++) {
		vec3 curr_point = camera_pos + ray_direction * distance_from_origin;
		float distance_to_the_scene = GetDistance(curr_point);
		distance_from_origin += distance_to_the_scene;
		
		if(distance_from_origin > MAY_DISTANCE || 
			distance_to_the_scene < THRESHOLD_DISTANCE) {
			break;			
		}
	}
	return  distance_from_origin;
}


vec3 GetNormal(vec3 p) {
	float d = GetDistance(p);
    vec2 e = vec2(.01, 0);
    
    vec3 n = d - vec3(
        GetDistance(p-e.xyy),
        GetDistance(p-e.yxy),
        GetDistance(p-e.yyx));
    
    return normalize(n);
}

float GetLight(vec3 point) {
	vec3 light_pos = vec3(0, 5, 6);
	light_pos.xz += vec2(sin(uTime), cos(uTime))*2.;
	vec3 light_vector = normalize(light_pos - point);
	vec3 surface_normal = GetNormal(point);
	float diffuse = clamp(dot(light_vector, surface_normal), 0., 1.);
	
	// Shadow Calculation
	float direction = RayMarching(point + surface_normal * THRESHOLD_DISTANCE * 2. , light_vector);
	if(direction < length(light_pos - point)) {
		diffuse *= .1;
	}
	
	return diffuse;
}



void main()
{
	vec2 uv = (gl_FragCoord.xy - .5f * uResolution.xy) / uResolution.y;
	
	// Camera Model
	vec3 camera_pos = vec3(0.f, 1.f, 0.f);
	vec3 ray_direction = normalize(vec3(uv, 1.f));
	
	float final_distance = RayMarching(camera_pos, ray_direction);
	
	vec3 point = camera_pos + ray_direction * final_distance;
	float diffuse = GetLight(point);
	
	vec3 final_color = vec3(diffuse);
	
	// Gamma Correction
	final_color = pow(final_color, vec3(.4545));
	
	outColor = vec4(final_color, 1.0f);
}