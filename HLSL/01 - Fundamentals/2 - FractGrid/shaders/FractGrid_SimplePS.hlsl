cbuffer vars : register(b0)
{
	float2 uResolution;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = fragCoord.xy/uResolution;
    return float4(1.0f, 0.0f, 0.0f, 1.0f);
}
