shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 5.0 + VERTEX.y * 20.0) * 0.2;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	
	ALBEDO = color;
}