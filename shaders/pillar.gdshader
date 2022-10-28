shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.x += sin(TIME * 5.0 - VERTEX.y * 5.0) * 0.5;
}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	
	ALBEDO = color;
}