cbuffer vars : register(b0)
{
	float2 uResolution;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
	float2 uv = fragCoord / uResolution;
	float3 uvColor = float3(uv.x, uv.y, 0.0);
	float2 borderPixel = 100 / uResolution;
	
	float r0 = step(borderPixel.x, uv.x);
	float r1 = step(uv.x, 1 - borderPixel.x);
	float r2 = step(borderPixel.y, uv.y);
	float r3 = step(uv.y, 1 - borderPixel.y);
	float border = r0 * r1 * r2 * r3;
	float3 mask = 1.0 - border;
	
	float3 finalColor = uvColor * mask;

	
	
    return float4(finalColor, 1.0);
}
