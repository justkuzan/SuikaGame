extends Node2D
class_name ScoreManager

@export var flower_resources: Array[FlowerData] = []

var combo_multiplier: int = 1

#var score_tween: Tween


func _ready() -> void:
	SignalBus.flower_merged.connect(on_flower_merged)
	SignalBus.combo_updated.connect(on_combo_updated)


func on_flower_merged(_pos: Vector2, lvl: int) -> void:
	var flower_merged_resource: FlowerData = flower_resources[(lvl-1)]
	GameManager.total_score += flower_merged_resource.score_value * combo_multiplier

	if GameManager.total_score > GameManager.high_score:
		GameManager.high_score = GameManager.total_score
		SignalBus.high_score_changed.emit(GameManager.high_score)

	GameManager.total_coins += flower_merged_resource.coin_value

	SignalBus.score_changed.emit(GameManager.total_score)
	SignalBus.coins_changed.emit(GameManager.total_coins)


func on_combo_updated(_pos: Vector2, _combo_count: int, new_combo_multiplier: int) -> void:
	combo_multiplier = new_combo_multiplier


#func score_animation() -> void:
	#if score_tween:
		#score_tween.kill()
#
	#$ScoreLabel.scale = Vector2.ONE
#
	#score_tween = get_tree().create_tween()
	#score_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
#
	#score_tween.tween_property($ScoreLabel, "scale", Vector2(1.25, 1.25), 0.2)
	#score_tween.tween_property($ScoreLabel, "scale", Vector2.ONE, 0.2)
