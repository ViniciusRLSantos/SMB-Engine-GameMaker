//TFX - Circle
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float smoothness;

const vec2 center = vec2(0.5, 0.5);
const float SQRT_2 = 1.414213562373;

void main() {	
	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 to_colour = texture2D(to_texture, v_vTexcoord);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
	float ratio = resolution.y/resolution.x;	
	vec2 uv = vec2(v_vTexcoord.x,((v_vTexcoord.y-0.5)*ratio)+0.5);

	float m = smoothstep(-smoothness, 0.0, SQRT_2*distance(center, uv) - progress*(1.0+smoothness));
		
    gl_FragColor = v_vColour * mix(to_colour, from_colour, m);
}
