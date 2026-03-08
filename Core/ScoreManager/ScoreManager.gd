extends Node2D
class_name ScoreManager

@export var flower_resources: Array[FlowerData] = []
#var score_tween: Tween


func _ready() -> void:
	SignalBus.flower_merged.connect(on_flower_merged)


func on_flower_merged(pos: Vector2, lvl: int) -> void:
	pass


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
