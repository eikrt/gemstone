shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.y * 20.0) * 0.2;
	VERTEX.x += sin(TIME * 5.0 + VERTEX.x) * 0.1;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	color.g += 1.0 + sin(TIME);
	ALBEDO = color;
}