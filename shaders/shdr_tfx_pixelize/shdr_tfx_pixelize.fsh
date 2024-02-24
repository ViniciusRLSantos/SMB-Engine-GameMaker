//TFX - Pixelize
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float max_size;
uniform float steps;

void main(){	
	float d = min(progress, 1.0 - progress)*2.0;
	float dist = (steps > 0.0) ? ceil(d * steps) / steps : d;
	vec2 pixel_size = vec2(1.0/(resolution.x/(max_size*dist)),1.0/(resolution.y/(max_size*dist)));

	vec2 uv = (dist > 0.0) ? (floor(v_vTexcoord / pixel_size) + 0.5) * pixel_size : v_vTexcoord;
	
	vec4 from_colour = texture2D(gm_BaseTexture, uv);
	vec4 to_colour = texture2D(to_texture, uv);
	if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
	if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }

	gl_FragColor = v_vColour *  mix(from_colour, to_colour, progress);
}
