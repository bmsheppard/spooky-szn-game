shader_type canvas_item;

uniform vec3 luminance: source_color = vec3(0.3086, 0.6094, 0.0820);
uniform vec3 base_color: source_color = vec3(0.2, 1.0, 0.4);
uniform float brightness: hint_range(0.1, 10.0, 0.01) = 2.0;
uniform float noise_level: hint_range(0.0, 1.0, 0.01) = 0.2;
uniform float vignette_level: hint_range(0.0, 1.0, 0.01) = 0.5;
uniform float edge_x: hint_range(0.0, 6.0, 0.01) = 4.0;
uniform float edge_y: hint_range(0.0, 6.0, 0.01) = 4.0;

float hash11(float x) {
	return fract(cos(mod(dot(vec2(x, x), vec2(13.9898, 0.141)), PI)) * 43758.5453);
}

void fragment() {
	vec2 uv = UV - 0.5;
	vec2 res = 1.0 / TEXTURE_PIXEL_SIZE;
	uv.x *= res.x / res.y;
	float time = TIME;
	vec3 color = texture(TEXTURE, UV).rgb;
	float grain = hash11(uv.x) + uv.y;
	color += hash11(grain * time) * noise_level;
	vec2 edge = uv * uv * uv * vec2(edge_x, edge_y);
	color *= smoothstep(length(edge), 1.0, vignette_level);
	vec3 vision_color = base_color;
	color = dot(color, luminance) * vision_color;
	COLOR = vec4(color * brightness, 0.4);


    // make the pixel completely transparent
    // if it's outside the radius of the circle
    //COLOR.a = 1.0 - round(distance(UV, vec2(0.5, 0.5)));
}