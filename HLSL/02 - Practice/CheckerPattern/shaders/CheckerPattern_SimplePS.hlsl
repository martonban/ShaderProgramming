cbuffer vars : register(b0)
{
	float2 uResolution;
	float uTime;
};

float4 main(float4 fragCoord : SV_POSITION) : SV_TARGET
{
    float2 uv = fragCoord.xy/uResolution;
	float cx = step(0.5, frac(uv.x * 4.0));
	float cy = step(0.5, frac(uv.y * 4.0));
	float ch = abs(cx - cy);
	
	float3 color1 = float3(0.9608, 0.8627, 0.7098);
	float3 color2 = float3(0.7333, 0.5529, 0.3843);
	
	
	// Without IF
	// Better Performance
	float t = step(0.0001, ch);
	float3 finalColor = lerp(color1, color2, t);
    
    // With IF
    // Worst Perfomance
    /*
    float3 finalColor;
    if(ch == 0.0) {
    	finalColor = color1;
    } else {
    	finalColor = color2;
    }
    */
    
    return float4(finalColor, 1.0);
}
