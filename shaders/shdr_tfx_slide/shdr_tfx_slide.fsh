//TFX - Slide
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float direction;

void main(){
	vec2 dir = vec2(cos(radians(direction)),-sin(radians(direction)));
	dir.x = floor(abs(dir.x)+0.5)*dir.x;
	dir.y = floor(abs(dir.y)+0.5)*dir.y;
	vec2 p = v_vTexcoord + progress * sign(dir);
	vec2 f = fract(p);
	
	vec4 from_colour = texture2D(gm_BaseTexture, f);
	vec4 to_colour = texture2D(to_texture, f);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
	
	gl_FragColor = v_vColour * mix(to_colour, from_colour, step(0.0, p.y) * step(p.y, 1.0) * step(0.0, p.x) * step(p.x, 1.0));
}
