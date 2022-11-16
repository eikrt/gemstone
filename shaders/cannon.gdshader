shader_type spatial;
uniform sampler2D tex;
uniform vec3 c;
void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.y * 20.0) * 0.2;
	VERTEX.x += sin(TIME * 5.0 + VERTEX.x) * 0.1;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	color.r += c.r;
	color.g += c.g;
	color.b += c.b;
	color.g += sin(TIME);
	ALBEDO = color;
}