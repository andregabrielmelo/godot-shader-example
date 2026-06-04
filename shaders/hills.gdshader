shader_type spatial;
uniform sampler2D noise;
uniform float escala_altura = 0.5;
varying float height;

uniform sampler2D gradient_texture;

float altura(vec2 position){
	position = position / 2.0 + 0.5;
	float altura = texture(noise, position / 10.0).x;
	return altura;
}

void vertex() {
	vec2 pos = VERTEX.xz;
	float k = altura(pos);
	VERTEX.y = k * cos(TIME);
	height = VERTEX.y;
	NORMAL = normalize(vec3(k - altura(pos + vec2(0.1, 0.0)), 0.1, k - altura(pos + vec2(0.0, 0.1))));
	// Called for every vertex the material is visible on.
}

void fragment() {
	float normalized = (height + 1.0) * 0.5;
	ALBEDO = texture(gradient_texture, vec2(normalized, 0.5)).rgb;
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
