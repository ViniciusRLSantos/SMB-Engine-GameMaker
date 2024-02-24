//TFX - Wipe
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float direction;
uniform float smoothness;

void main() {
	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 to_colour = texture2D(to_texture, v_vTexcoord);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
		
	vec2 v = vec2(cos(radians(direction)),-sin(radians(direction)));
	v /= abs(v.x)+abs(v.y);
	float d = v.x * 0.5 + v.y * 0.5;
	
	float m = (1.0-step(progress, 0.0)) * (1.0 - smoothstep(-smoothness, 0.0, v.x * v_vTexcoord.x + v.y * v_vTexcoord.y - (d-0.5+progress*(1.+smoothness))));
	gl_FragColor = v_vColour *  mix(from_colour, to_colour, m);
}
