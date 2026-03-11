extends CanvasLayer
class_name InGameUI

@export var animation_duration: float = 0.15

@onready var counter_label: Label = %"Counter-Label"
@onready var coins_label: Label = %"Coins-Label"


func _ready() -> void:
	SignalBus.score_changed.connect(on_score_changed)
	SignalBus.coins_changed.connect(on_coins_changed)

	counter_label.text = str(GameManager.total_score)
	coins_label.text = str(GameManager.total_coins)


func update_score_label(current_value: int):
	counter_label.text = str(current_value)


func update_coins_label(current_value: int):
	coins_label.text = str(current_value)


func pulse_tween(label: Label) -> void:
	var tween = create_tween()
	tween.tween_property(label, "scale", Vector2(1.4, 1.4), animation_duration)
	tween.tween_property(label, "scale", Vector2.ONE, animation_duration)


func on_score_changed(score: int) -> void:
	update_score_label(score)

	counter_label.pivot_offset = counter_label.size / 2
	pulse_tween(counter_label)


func on_coins_changed(coins: int) -> void:
	update_coins_label(coins)

	coins_label.pivot_offset = coins_label.size / 2
	pulse_tween(coins_label)
