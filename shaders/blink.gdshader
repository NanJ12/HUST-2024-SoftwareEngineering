shader_type canvas_item;

uniform vec4 blink_color : source_color;
uniform float blink_power : hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color = mix(color, blink_color * color.a, blink_power);
	COLOR = color;
}
