shader_type spatial;
uniform sampler2D tex;
void vertex() {
	VERTEX.y += sin(TIME * 10.0 + VERTEX.x * 30.0) * 1.5;
	VERTEX.y += sin(TIME * 5.0) * 2.0;
	}
void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	color.r += 1.0 + sin(TIME * 0.5);
	METALLIC = 1.5 + sin(TIME);
	ROUGHNESS = 1.5 + sin(TIME);
	ALBEDO = color;
}