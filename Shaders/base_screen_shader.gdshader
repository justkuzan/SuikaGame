shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear;
uniform float vignette_intensity = 0.4;
uniform float grain_amount = 0.02;

// Быстрый шум для зерна
float noise(vec2 uv, float time) {
    return fract(sin(dot(uv, vec2(12.9898, 78.233) + time)) * 43758.5453);
}

void fragment() {
    vec2 uv = SCREEN_UV;
    
    // 1. Берем исходный цвет (теперь только одна выборка текстуры — это очень быстро)
    vec4 screen_color = texture(SCREEN_TEXTURE, uv);
    vec3 final_color = screen_color.rgb;
    
    // 2. Мягкая Виньетка (затемнение по краям)
    float d = distance(uv, vec2(0.5));
    final_color *= smoothstep(0.8, 0.8 - vignette_intensity, d);
    
    // 3. Тонкое зерно (оживляет статичный фон)
    float n = noise(uv, TIME);
    final_color += (n - 0.5) * grain_amount;
    
    // 4. Легкая засветка (Fake Bloom) — подсвечиваем только яркие участки (небо в окне)
    float brightness = (final_color.r + final_color.g + final_color.b) / 3.0;
    if (brightness > 0.8) {
        final_color += 0.04; 
    }

    COLOR = vec4(final_color, 1.0);
}