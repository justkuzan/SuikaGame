extends Node2D
class_name ScoreManager

@onready var score_label: Label = $ScoreLabel

var total_score: int
var score_tween: Tween


func _ready() -> void:
	SignalBus.on_flower_collide.connect(on_flower_collide)


func on_flower_collide(_position: Vector2, _data: FlowerData, _flower_a: RigidBody2D, _flower_b: RigidBody2D) -> void:
	total_score += 1
	score_label.text = "%03d" % total_score
	score_animation()


func score_animation() -> void:
	if score_tween:
		score_tween.kill()

	$ScoreLabel.scale = Vector2.ONE

	score_tween = get_tree().create_tween()
	score_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	score_tween.tween_property($ScoreLabel, "scale", Vector2(1.25, 1.25), 0.2)
	score_tween.tween_property($ScoreLabel, "scale", Vector2.ONE, 0.2)
