shader_type spatial;
render_mode unshaded;

uniform int pixel_size = 1; //resolution must be divisible by pixel_size
uniform float progress: hint_range(0, 1);


void fragment() {

	float vx = VIEWPORT_SIZE.x / 2.0 + sin(TIME) * VIEWPORT_SIZE.x / 2.0;
	float vy = VIEWPORT_SIZE.y / 2.0;
	float angle = atan(vx - FRAGCOORD.x, vy - FRAGCOORD.y);
	float x = float(int(FRAGCOORD.x - cos(angle)));
	float y = float(int(FRAGCOORD.y - sin(angle)));
	x = FRAGCOORD.x - cos(angle) * 100.0;
	y = FRAGCOORD.y - sin(angle) * 100.0;
	
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;

}