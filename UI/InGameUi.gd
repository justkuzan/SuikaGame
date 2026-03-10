extends CanvasLayer
class_name InGameUI

@export var animation_duration: float = 0.3

@onready var counter_label: Label = %"Counter-Label"
@onready var coins_label: Label = %"Coins-Label"


func _ready() -> void:
	SignalBus.score_changed.connect(on_score_changed)
	SignalBus.coins_changed.connect(on_coins_changed)

	counter_label.text = str(GameManager.total_score)
	coins_label.text = str(GameManager.total_coins)


# Универсальная функция для "тиканья" цифр и пульсации
func animate_value(label: Label, new_val: int) -> void:
	var old_val = int(label.text)

	# Создаем твин
	var tween = create_tween().set_parallel(true).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	# 1. Анимируем цифры (через лямбда-функцию)
	tween.tween_method(func(v): label.text = str(v), old_val, new_val, animation_duration)

	# 2. Дизайнерская пульсация (Scale)
	label.pivot_offset = label.size / 2 # Чтобы увеличивался из центра

	# Сначала увеличиваем
	var pulse_tween = create_tween()
	pulse_tween.tween_property(label, "scale", Vector2(1.15, 1.15), animation_duration / 2)
	pulse_tween.tween_property(label, "scale", Vector2.ONE, animation_duration / 2)


# Обработчики сигналов
func on_score_changed(score: int) -> void:
	animate_value(counter_label, score)


func on_coins_changed(coins: int) -> void:
	animate_value(coins_label, coins)
