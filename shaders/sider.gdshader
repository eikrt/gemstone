shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 10.0 + VERTEX.x * 10.0) * 0.1;
	}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	color.g += 1.0 + sin(TIME * 0.5);
	METALLIC = 1.5 + sin(TIME);
	ROUGHNESS = 1.5 + sin(TIME);
	ALBEDO = color;
}