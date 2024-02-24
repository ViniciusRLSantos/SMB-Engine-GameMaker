//TFX - Fade Ripple
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float amplitude;
uniform float frequency;
uniform float speed;

void main(){
	float ratio = resolution.y/resolution.x;
	vec2 uv = vec2(v_vTexcoord.x,((v_vTexcoord.y-0.5)*ratio)+0.5);
	vec2 dir = uv - vec2(0.5);
	float dist = length(dir);

	vec2 offset = dir * sin(dist * frequency - progress * speed) / (50.0 / (amplitude));
	vec2 offset2 = dir * sin(dist * frequency - progress * speed) / (50.0 / (amplitude*(1.0 - progress)*2.0));
	
	if (dist > progress) {
		vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
		vec4 to_colour = texture2D(to_texture, v_vTexcoord);
		if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
		gl_FragColor = v_vColour * from_colour;
	} else {
		vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord + offset);
		vec4 to_colour = texture2D(to_texture, v_vTexcoord + offset2);
		if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
		if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
		gl_FragColor = v_vColour * mix(from_colour, to_colour, progress);
	}
}
