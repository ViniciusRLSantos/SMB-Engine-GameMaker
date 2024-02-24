//TFX - Fade Blur
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D to_texture;
uniform vec2 resolution;

uniform float progress;
uniform float blur_size;

const int passes = 16; //blur quality

void main() {
	
    vec4 final_from_colour = vec4(0.0);
    vec4 final_to_colour = vec4(0.0);
	vec2 pass_uv = vec2(0.0);

    vec2 displacement = vec2(1.0/resolution.x,1.0/resolution.y);
	displacement *= blur_size*(0.5-distance(0.5, progress));
    
	for (int xi = 0; xi < passes; xi++) {
        pass_uv.x = float(xi) / float(passes) - 0.5;
        for (int yi = 0; yi < passes; yi++) {
            pass_uv.y = float(yi) / float(passes) - 0.5;
			
			vec4 from_colour = texture2D(gm_BaseTexture, v_vTexcoord + displacement*pass_uv);
			vec4 to_colour = texture2D(to_texture, v_vTexcoord + displacement*pass_uv);
			if (from_colour.a == 0.0) {	from_colour.rgb = to_colour.rgb; }
			if (to_colour.a == 0.0) { to_colour.rgb = from_colour.rgb; }
			
            final_from_colour += from_colour;
            final_to_colour += to_colour;
        }
    }
	
    final_from_colour /= float(passes*passes);
    final_to_colour /= float(passes*passes);
	
    gl_FragColor = v_vColour * mix(final_from_colour, final_to_colour, progress);
}
