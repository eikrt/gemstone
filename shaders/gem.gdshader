shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 5.0) * 0.2;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	color.r = sin((VERTEX.x + 0.5) * 0.9);
	color.g = sin((VERTEX.y + 0.5) * 0.7);
	color.b = sin((VERTEX.z + 0.5) * 0.8);

	METALLIC = 1.0;
	ALPHA = 0.9;
	ALBEDO = color;
}