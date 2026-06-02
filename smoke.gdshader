shader_type spatial;

uniform sampler2D fire_gradient;
uniform sampler2D noise_texture;
uniform float speed = 1.0;
uniform float varying_color = 1.0;
varying float height;

void vertex() {
	height = VERTEX.y;
	
}

void fragment() {
	vec2 _uv = UV;
	float normalized_height = (height + 1.0) * 0.5;
	_uv.y +=  mod(UV.y + TIME * speed, 1.0);
	vec3 inverted_noise = vec3(1.0,1.0,1.0) - texture(noise_texture,_uv).rgb;
	
	inverted_noise.r += height * varying_color;
	ALBEDO = texture(fire_gradient, vec2(normalized_height, 0.5)).rgb;
	NORMAL_MAP = inverted_noise;
	
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
