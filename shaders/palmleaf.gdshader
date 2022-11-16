shader_type spatial;
uniform sampler2D tex;
uniform sampler2D normalmap;
float random (vec2 uv) {
    return fract(sin(dot(uv.xy,
        vec2(12.9898,78.233))) * 43758.5453123);
}
void vertex() {
	VERTEX.y += (sin(TIME + VERTEX.x)) * distance(vec2(0.0,0.0), VERTEX.xz) / 64.0;
}


void fragment() {
	vec3 color;
	color = texture(tex, UV).rgb;
	ALBEDO = color;
	NORMAL_MAP = texture(normalmap, UV).rgb;
}