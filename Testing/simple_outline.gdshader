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
		}
	}
bool hasContraryNeighbour(vec2 uv, vec2 texture_pixel_size, sampler2D _texture) {
	for (float x = -1.0; x <=1.0; x++) {
		float offset;
		offset = 1.0 - abs(x);
		for (float y = -ceil(offset); y <= ceil(offset); y++) {
			vec2 xy = uv + texture_pixel_size * vec2(x, y);

			if (!(xy != clamp(xy, vec2(0.0), vec2(1.0)) || texture(_texture, xy).a <= 0.0)) {
				return true;
			}
		}
	}
	return false;
}

void fragment() {
	vec2 uv = UV;

	vec2 texture_pixel_size = 1.0 / (1.0 / TEXTURE_PIXEL_SIZE + 2.0);

	uv = (uv - texture_pixel_size) * TEXTURE_PIXEL_SIZE / texture_pixel_size;

	if (enable)
		{
		if (uv != clamp(uv, vec2(0.0), vec2(1.0))) {
			COLOR.a = 0.0;
		} else {
			COLOR = texture(TEXTURE, uv) * modulate;
		}
		

		if (COLOR.a <= 0.0 && hasContraryNeighbour(uv, TEXTURE_PIXEL_SIZE, TEXTURE)) {
			COLOR.rgb = color.rgb * modulate.rgb;
			COLOR.a += (1.0 - COLOR.a) * color.a * modulate.a;
		}
	}
}