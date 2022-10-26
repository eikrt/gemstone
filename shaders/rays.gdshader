shader_type spatial;
render_mode unshaded;

uniform int pixel_size = 1; //resolution must be divisible by pixel_size
uniform float progress: hint_range(0, 1);


void fragment() {
	float x = float(int(FRAGCOORD.x) % pixel_size);
	float y = float(int(FRAGCOORD.y) % pixel_size);
	float angle = atan(VIEWPORT_SIZE.x / 2.0 - x, VIEWPORT_SIZE.y / 2.0 - y);
	x = FRAGCOORD.x - cos(angle) * 100.0;
	y = FRAGCOORD.y - sin(angle) * 100.0;
	
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;

}