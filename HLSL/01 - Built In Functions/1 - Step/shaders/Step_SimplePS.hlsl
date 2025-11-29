cbuffer vars : register(b0)
{
	float2 uResolution;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = fragCoord.xy/uResolution;
    
    float t = step(0.5, uv.x);
    return float4(t, 0.0, 0.0, 1.0);
}
