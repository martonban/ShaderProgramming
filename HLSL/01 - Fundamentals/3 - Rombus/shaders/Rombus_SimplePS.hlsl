cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
  // Normalized pixel coordinates (from 0 to 1)
  float2 uv = fragCoord.xy / uResolution.xy;
  float t1 = step((uv.x + 0.5), uv.y);
  float t2 = step(((1 - uv.x) + 0.5), uv.y);
  float t3 = step((uv.y + 0.5), uv.x);
  float t4 = step(uv.x, ((1 - uv.y) - 0.5));
  float final = 1 - (t1 + t2 + t3 + t4);
  
  return float4(final, 0.0, 0.0, 1.0);
}
