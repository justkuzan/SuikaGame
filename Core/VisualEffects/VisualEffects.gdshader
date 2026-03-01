shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float grain_amount : hint_range(0.0, 0.1) = 0.03;
uniform float vignette_intensity : hint_range(0.0, 1.0) = 0.4;
uniform float aberration_amount : hint_range(0.0, 5.0) = 1.0;

float random(vec2 uv) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // Хроматическая аберрация
    float r = texture(screen_texture, uv + vec2(SCREEN_PIXEL_SIZE.x * aberration_amount, 0.0)).r;
    float g = texture(screen_texture, uv).g;
    float b = texture(screen_texture, uv - vec2(SCREEN_PIXEL_SIZE.x * aberration_amount, 0.0)).b;
    vec3 color = vec3(r, g, b);
    
    // Зернистость
    float noise = (random(uv + TIME) - 0.5) * grain_amount;
    color += noise;
    
    // Виньетка
    float dist = distance(uv, vec2(0.5, 0.5));
    color *= smoothstep(0.8, 0.8 - vignette_intensity, dist);
    
    COLOR = vec4(color, 1.0);
}