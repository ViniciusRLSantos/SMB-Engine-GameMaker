//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;
uniform float speed;
uniform float saturation;
uniform float brightness;

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 1.0/2.0, 1.0/3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz)*6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p-K.xxx, 0.0, 1.0), c.y);
}

void main()
{
    //float pos = (v_vTexcoord.x - u_uv[0]) / (u_uv[1] - u_uv[0]);
    vec3 col = vec3(v_vTexcoord.x + v_vTexcoord.y + (time * speed), saturation, brightness);
    float alpha = texture2D(gm_BaseTexture, v_vTexcoord).a;
    gl_FragColor = v_vColour * vec4(hsv2rgb(col), alpha);
}
