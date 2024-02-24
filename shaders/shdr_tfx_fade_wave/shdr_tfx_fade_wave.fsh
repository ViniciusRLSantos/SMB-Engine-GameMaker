//TFX - Fade Wave
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float frequency;
uniform float amplitude;

vec2 offset(float progress, float x, float theta) {
	float phase = progress*progress + progress + theta;
	float shifty = amplitude*progress*cos(frequency*(progress+x));
	return vec2(0, shifty);
}

void main() {

	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord + offset(progress, v_vTexcoord.x, 0.0));
	vec4 to_colour = texture2D(to_texture, v_vTexcoord + offset(1.0-progress, v_vTexcoord.x, 3.14));
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
    gl_FragColor = v_vColour * mix(from_colour, to_colour, progress);
}
