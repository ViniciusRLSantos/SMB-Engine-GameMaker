//TFX - Fade
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;

void main(){
	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 to_colour = texture2D(to_texture, v_vTexcoord);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
	gl_FragColor = v_vColour * mix(from_colour, to_colour, progress);
}
