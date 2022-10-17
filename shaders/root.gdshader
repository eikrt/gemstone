shader_type spatial;
render_mode unshaded;
uniform float zNear = 0.05;
uniform float zFar  = 100.0;
void vertex() {
	// Place fragment code here.
	POSITION = vec4(VERTEX, 1.0);
}
void fragment() {
	vec4 original = texture(SCREEN_TEXTURE, SCREEN_UV);
	ALBEDO = original.rgb;
	float depth = texture(DEPTH_TEXTURE, SCREEN_UV).x;
	vec3 ndc = vec3(SCREEN_UV, depth) * 2.0 - 1.0;
	vec4 view = INV_PROJECTION_MATRIX * vec4(ndc, 1.0);
	view.xyz /= view.w;
	float linear_depth = view.z;
	float scaled_depth = (zFar * zNear) / (zFar + (linear_depth * (zNear - zFar)));
	ALBEDO = vec3(scaled_depth);
	}