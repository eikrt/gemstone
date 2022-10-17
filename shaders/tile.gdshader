shader_type canvas_item;

uniform vec2 scale = vec2(1, 1);
uniform vec2 offset = vec2(0, 0);
uniform vec2 zoomto = vec2(0.5, 0.5);

void fragment() {
    vec2 new_uv = SCREEN_UV;
    new_uv -= zoomto;
    
    new_uv = new_uv * scale;
    
    new_uv += zoomto;
    
    new_uv = mod(new_uv, 1);
    
    new_uv += offset;
    COLOR = textureLod(SCREEN_TEXTURE, new_uv, 0.0);
}