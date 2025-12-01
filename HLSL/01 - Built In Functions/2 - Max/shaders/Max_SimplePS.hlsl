cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = fragCoord.xy/uResolution;
    float3 color = float3(1.0, 0.3, 0.3);
    float t1 = 1.0 - step(0.25, uv.x); 
    float t2 = step(0.75, uv.x); 
	float3 finalColor = color * max(t1, t2);
    
    return float4 (finalColor, 1.0f);

}
