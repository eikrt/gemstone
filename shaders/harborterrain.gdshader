shader_type spatial;
uniform sampler2D tex;
uniform sampler2D normalmap;
varying vec3 world_position;
void vertex() {
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	float h_thing = world_position.y / 22.0;
	if (h_thing > 0.0) {
		h_thing /= 2.0;
	}
	color.r += h_thing;
	color.g += h_thing;
	color.b += h_thing;
	ALBEDO = color;
	NORMAL_MAP = texture(normalmap, UV).rgb;
}