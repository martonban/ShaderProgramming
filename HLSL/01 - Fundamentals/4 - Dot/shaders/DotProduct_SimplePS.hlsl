cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = fragCoord.xy/uResolution;
    float2 ratio = float2(uResolution.x/uResolution.y, 1.0);
    uv *= ratio;
    
    // Ancor vectors
    float2 center = float2(0.5, 0.75) * ratio;
    float2 h = normalize(center - (float2(0.5, 0.25) * ratio)) ;
    
    
    float2 ray = normalize((center - uv)) * ratio;
    float t = dot(ray, h);
    float q = step(0.5, t);	
    float y = step(0.25, uv.y);

    
    
    return float4(q * y, 0.0, 0.0, 1.0f);
}
