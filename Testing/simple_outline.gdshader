shader_type canvas_item;

uniform vec4 color : source_color = vec4(1.0);
uniform bool enable = false;
varying flat vec4 modulate;

void vertex()
	{
	modulate = COLOR;
	if (enable)
		{
		if ((UV.x <= 0.0 || UV.x >= 1.0) && (UV.y <= 0.0 || UV.y >= 1.0))
			{
				VERTEX += UV * 2.0 - 1.0;
			}
		else
			{
				VERTEX += sign(VERTEX) * 2.0 - 1.0;
			}
		}
	}
bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, vec2 image_top_left, vec2 image_bottom_right, sampler2D texture) {
	for (float i = -1.0; i <=1.0; i++) {
		float x = abs(i) > 1.0 ? 1.0 * sign(i) : i;
		float offset;
		offset = 1.0 - abs(x);
		for (float j = -ceil(offset); j <= ceil(offset); j++) {
			float y = abs(j) > offset ? offset * sign(j) : j;
			vec2 xy = uv + texture_pixel_size * vec2(x, y);

			if (!(xy != clamp(xy, image_top_left, image_bottom_right) || texture(texture, xy).a <= 0.0)) {
				return true;
			}
		}
	}

	return false;
}

void fragment() {
	vec2 uv = UV;
	vec2 image_top_left = floor(uv * vec2(1.0)) / vec2(1.0);
	vec2 image_bottom_right = image_top_left + vec2(1.0) / vec2(1.0);

	vec2 texture_pixel_size = vec2(1.0) / (vec2(1.0) / TEXTURE_PIXEL_SIZE + vec2(2.0) * vec2(1.0));

	uv = (uv - texture_pixel_size - image_top_left) * TEXTURE_PIXEL_SIZE / texture_pixel_size + image_top_left;

	if (enable)
		{
		if (uv != clamp(uv, image_top_left, image_bottom_right)) {
			COLOR.a = 0.0;
		} else {
			COLOR = texture(TEXTURE, uv) * modulate;
		}
		

		if ((COLOR.a > 0.0) == false && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, image_top_left, image_bottom_right, TEXTURE)) {
			COLOR.rgb = false ? mix(COLOR.rgb, color.rgb * modulate.rgb, color.a * modulate.a) : color.rgb * modulate.rgb;
			COLOR.a += (1.0 - COLOR.a) * color.a * modulate.a;
		}
	}
}