shader_type spatial;
uniform sampler2D tex;
varying vec3 world_position;
uniform vec3 position;
varying vec3 lpos;
void vertex() {
	float angle = atan(VERTEX.y,VERTEX.x);
	//VERTEX.y += sin(angle + TIME * 1.8) * 0.2;
	//VERTEX.x += cos(angle + TIME * 1.8) * 0.9;
	//VERTEX.z += sin(angle * TIME * 0.1) * 0.2;
	world_position = (MODEL_MATRIX * vec4(VERTEX, 1.0)).xyz;
	lpos = VERTEX;
}
void fragment(){
   	//vec4 color = texture(SCREEN_TEXTURE, UV);
	vec3 color = vec3(0.0,0.0,0.0);
	float color_pos = sin(world_position.y * 1.0);
	float alpha_pos = cos(world_position.y * 1.0);
	color.r = 0.5;
	float rvalue = 1.0 - distance(lpos.x, 0) + (lpos.y) * (0.0 - sin(TIME * 3.0));
	//ROUGHNESS += rvalue;
	METALLIC += 1.0/rvalue;
	ALPHA += rvalue;
	if (ALPHA <= 0.0) {
		ALPHA = 0.5;
	}
	//ALPHA += FRAGCOORD.x;
	//METALLIC += length(VERTEX.x);
	//color.g = 0.5;
	//ALPHA += alpha_pos;
	//METALLIC = sin(TIME);
	/*color.r += (0.5 + sin(VERTEX.y)) * 1.1;
	color.g += (0.5 + sin(VERTEX.y)) * 1.1;
	color.b += (0.5 + sin(VERTEX.y)) * 1.1;*/
	//float angle = atan(world_position.y ,world_position.x);
	//color = vec3(cos(angle), cos(angle), cos(angle));
	//float dist = sqrt(pow(VERTEX.y - world_position.y, 2.0) + pow(VERTEX.x - world_position.x, 2.0)) * 1.0;
	//float dist = length(VERTEX);
	//color = vec3(sin(TIME), sin(TIME), sin(TIME));
	
	ALBEDO = vec3(color.r,color.g,color.b);
	
	//ALBEDO = vec3(SCREEN_UV.r,SCREEN_UV.r,SCREEN_UV.r);
}

