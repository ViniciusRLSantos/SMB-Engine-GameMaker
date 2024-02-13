//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec3 color;
uniform float alpha;

void main()
{
	
	vec4 texColor = texture2D( gm_BaseTexture, v_vTexcoord );
    gl_FragColor = vec4(color, texColor.a*alpha);
}
