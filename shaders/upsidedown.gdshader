shader_type spatial;
render_mode blend_sub, unshaded;

uniform int pixel_size = 1; //resolution must be divisible by pixel_size
uniform float progress: hint_range(0, 1);
uniform float scale = 100;

void fragment() {

	
	float angle = atan(VIEWPORT_SIZE.x / 2.0 - FRAGCOORD.x, VIEWPORT_SIZE.y / 2.0 - FRAGCOORD.y);
	float x = float(int(FRAGCOORD.x));
	float y = float(int(FRAGCOORD.y));
	x = VIEWPORT_SIZE.x - FRAGCOORD.x;
	y = VIEWPORT_SIZE.y - FRAGCOORD.y;
	
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;

}