shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.x * 30.0) * 0.5;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
}