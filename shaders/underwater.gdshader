shader_type spatial;
render_mode unshaded;

uniform int pixel_size = 1; //resolution must be divisible by pixel_size
uniform float progress: hint_range(0, 1);
uniform float scale = 100;

void fragment() {

	
	float offset_x = cos(TIME + FRAGCOORD.x / 16.0) * 2.0;
	float offset_y = sin(TIME + FRAGCOORD.y / 64.0) * 2.0;
	float x = float(FRAGCOORD.x - offset_x);
	float y = float(FRAGCOORD.y - offset_y);
	//x = FRAGCOORD.x - scale;
	//y = FRAGCOORD.y - scale;
	
	ALBEDO = texture(SCREEN_TEXTURE, vec2(x, y) / VIEWPORT_SIZE).xyz;
	ALBEDO.b += 0.2;

}