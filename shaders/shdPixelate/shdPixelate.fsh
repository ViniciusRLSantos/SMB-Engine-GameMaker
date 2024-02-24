//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform int amount;

void main()
{
	vec2 grid_uv = floor(v_vTexcoord * float(amount))/float(amount);
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, grid_uv );
}
