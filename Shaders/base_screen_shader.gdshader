shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
uniform float vignette_intensity = 0.4;
uniform float aberration_amount = 0.002;
uniform float grain_amount = 0.03;

// Максимально дешевый генератор шума
float noise(vec2 uv, float time) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233) + time)) * 43758.5453);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    vec2 dist_vec = uv - vec2(0.5);
    float d = length(dist_vec); // Расстояние от центра
    
    // Умножаем силу аберрации на расстояние (в центре 0, по краям максимум)
    vec2 offset = dist_vec * aberration_amount;
    
    vec4 color = texture(SCREEN_TEXTURE, uv);
    float r = texture(SCREEN_TEXTURE, uv + offset).r;
    float b = texture(SCREEN_TEXTURE, uv - offset).b;
    vec3 final_color = vec3(r, color.g, b);
    
    // Виньетка
    final_color *= smoothstep(0.8, 0.8 - vignette_intensity, d);
    
    // Зерно
    final_color += (noise(uv, TIME) - 0.5) * grain_amount;
    
    COLOR = vec4(final_color, 1.0);
}