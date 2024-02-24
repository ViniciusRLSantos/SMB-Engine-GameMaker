//TFX - Random Squares
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float grid_width;
uniform float grid_height;
uniform float smoothness;

float rand (vec2 co) {
  return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void main() {
	vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord);
	vec4 to_colour = texture2D(to_texture, v_vTexcoord);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
	float r = rand(floor(vec2(grid_width,grid_height) * v_vTexcoord));
	float m = smoothstep(0.0, -smoothness, r - (progress * (1.0 + smoothness)));
	gl_FragColor = v_vColour * mix(from_colour, to_colour, m);
}
