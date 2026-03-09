extends Node
class_name ComboManager

var combo_counter: int = 0
var combo_multiplier: int = 1

@onready var combo_timer: Timer = $ComboTimer


func _ready() -> void:
	SignalBus.flower_merged.connect(on_flower_merged)


func on_flower_merged(_pos: Vector2, _lvl: int) -> void:
	if combo_timer.is_stopped():
		combo_counter = 1
	else:
		combo_counter += 1

	update_multiplier()
	combo_timer.start()
	SignalBus.combo_updated.emit(_pos, combo_counter, combo_multiplier)


func _on_combo_timer_timeout() -> void:
	combo_counter = 0
	combo_multiplier = 1
	SignalBus.combo_updated.emit(Vector2(), combo_counter, combo_multiplier)


func update_multiplier() -> void:
	if combo_counter < 2:
		combo_multiplier = 1
	else:
		combo_multiplier = (combo_counter / 2) * 2
