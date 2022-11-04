shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 2.0 + VERTEX.y * 1.0) * 0.2;
	VERTEX.y += sin(TIME * 1.0) * 0.5;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
}