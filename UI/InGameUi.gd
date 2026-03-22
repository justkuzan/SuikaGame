extends CanvasLayer
class_name InGameUI

@export var animation_duration: float = 0.15

@onready var counter_label: Label = %"Counter-Label"
@onready var coins_label: Label = %"Coins-Label"
@onready var combo_counter_label: Label = %"ComboCounter-Label"
@onready var combo_pop_up_control: Control = %"ComboPopUp-Control"


func _ready() -> void:
	SignalBus.score_changed.connect(on_score_changed)
	SignalBus.coins_changed.connect(on_coins_changed)
	SignalBus.combo_updated.connect(on_combo_updated)

	counter_label.text = str(GameManager.total_score)
	coins_label.text = str(GameManager.total_coins)

	combo_pop_up_control.scale = Vector2.ZERO


func update_score_label(current_value: int):
	counter_label.text = str(current_value)


func update_coins_label(current_value: int):
	coins_label.text = str(current_value)


func on_score_changed(score: int) -> void:
	update_score_label(score)

	counter_label.pivot_offset = counter_label.size / 2
	pulse_tween(counter_label)


func on_coins_changed(coins: int) -> void:
	update_coins_label(coins)

	coins_label.pivot_offset = coins_label.size / 2
	pulse_tween(coins_label)


func on_combo_updated(combo_count: int, _combo_multiplier: int) -> void:
	if combo_count == 3:
		combo_counter_label.text = str(combo_count)
		appearance_tween(combo_pop_up_control)
	elif combo_count > 3:
		combo_counter_label.text = str(combo_count)
		pulse_tween(combo_pop_up_control)
	elif combo_count == 0:
		disappearance_tween(combo_pop_up_control)


func pulse_tween(label: Node) -> void:
	var tween = create_tween()
	tween.tween_property(label, "scale", Vector2(1.4, 1.4), animation_duration)
	tween.tween_property(label, "scale", Vector2.ONE, animation_duration)


func appearance_tween(label: Node) -> void:
	label.scale = Vector2.ZERO
	var tween = create_tween()
	tween.tween_property(label, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BACK)


func disappearance_tween(label: Node) -> void:
	var tween = create_tween()
	tween.tween_property(label, "scale", Vector2.ZERO, 0.5).set_trans(Tween.TRANS_BACK)
