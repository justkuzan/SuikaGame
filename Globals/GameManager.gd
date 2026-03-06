extends Node

signal score_changed(score)
signal high_score_changed(high_score)
signal coins_changed(new_value)

var score: int = 0
var high_score: int
var coins: int

var is_game_over: bool = false


func _ready() -> void:
	SignalBus.flower_collide.connect(on_flower_collide)


func on_flower_collide(_pos, _data, _a, _b) -> void:
	score += 1

	if score > high_score:
		high_score = score
		emit_signal("high_score_changed", high_score)

	emit_signal("score_changed", score)
