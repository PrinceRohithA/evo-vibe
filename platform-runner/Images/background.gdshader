shader_type canvas_item;

uniform vec2 scroll_speed = vec2(0.0, -0.64);  // Change for different directions

void fragment() {
    vec2 uv_offset = UV + scroll_speed * TIME;
    COLOR = texture(TEXTURE, fract(uv_offset)); // Keeps it looping
}
