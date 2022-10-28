shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 10.0 + VERTEX.x * 30.0) * 0.4 * float(int(TIME) % 2);
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
}