shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 10.0 + VERTEX.x * 30.0) * 0.9;
	VERTEX.y += sin(TIME * 5.0) * 2.0;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
}