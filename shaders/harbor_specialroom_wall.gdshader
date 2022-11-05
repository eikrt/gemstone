shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.x += sin(TIME * 2.0 + VERTEX.x * 2.0) * 0.2;
	VERTEX.y += sin(TIME * 2.0 + VERTEX.x * 2.0) * 0.2;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
}