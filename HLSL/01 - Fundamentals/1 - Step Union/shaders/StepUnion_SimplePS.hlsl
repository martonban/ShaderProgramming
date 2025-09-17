cbuffer vars : register(b0)
{
	float2 uResolution;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    return float4(1.0, 0.0, 0.0, 1.0);
}
