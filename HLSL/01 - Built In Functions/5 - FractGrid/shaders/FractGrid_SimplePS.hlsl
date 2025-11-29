cbuffer vars : register(b0)
{
	float2 uResolution;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float cellSize = 50.0;
    float margin = 10.0;
    float2 cell = fragCoord.xy / cellSize;

    float2 t = frac(cell);
    return float4 (t, 0.0f, 1.0f);
}
