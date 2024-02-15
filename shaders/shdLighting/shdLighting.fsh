//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec2 v_vScreenPos;

uniform vec2 position;
uniform float radius;
uniform float lightMargin;
uniform float alpha;

void main()
{
    vec2 vect = vec2(v_vScreenPos.x - position.x, v_vScreenPos.y - position.y);
	float dist = sqrt(vect.x*vect.x + vect.y*vect.y);
	
	vec4 color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
	
	if (dist < radius - lightMargin) {
		color.a = floor(alpha*dist/radius);
		color.a *= alpha;
	} else if (dist > radius-lightMargin && dist < radius) {
		color.a = alpha*dist/radius;
		color.a *= alpha/2.0;
	} else {
		color = vec4(0.0, 0.0, 0.0, alpha);
		color.a *= alpha;
	}
	
	gl_FragColor = color;
	
}
