//TFX - Radial Wipe
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float starting_angle;
uniform float wipe_direction;
uniform float smoothness;

#define PI 3.141592653589

void main(){
	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 to_colour = texture2D(to_texture, v_vTexcoord);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
	float offset = radians(starting_angle);
	
	float angle = atan((1.0 - v_vTexcoord.y) - 0.5, (1.0-v_vTexcoord.x) - 0.5) + offset;
	float normalized_angle = (angle + PI) / (2.0 * PI);
	normalized_angle = normalized_angle - floor(normalized_angle);
	normalized_angle = (min(wipe_direction,0.0)*-1.0) + normalized_angle*wipe_direction;

	float smooth = smoothness*0.5;
	float m = smoothstep(normalized_angle-smooth, normalized_angle+smooth, progress*(1.0 + (smooth * 2.0))-smooth);

	gl_FragColor = v_vColour * mix(from_colour, to_colour, m);
}
