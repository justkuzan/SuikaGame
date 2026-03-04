extends Node2D
class_name ScoreManager

@onready var score_label: Label = $ScoreLabel

var score_tween: Tween


func _ready() -> void:
	GameManager.score_changed.connect(on_score_changed)


func on_score_changed(score: int) -> void:
	score_label.text = "%03d" % score
	score_animation()


func score_animation() -> void:
	if score_tween:
		score_tween.kill()

	$ScoreLabel.scale = Vector2.ONE

	score_tween = get_tree().create_tween()
	score_tween.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	score_tween.tween_property($ScoreLabel, "scale", Vector2(1.25, 1.25), 0.2)
	score_tween.tween_property($ScoreLabel, "scale", Vector2.ONE, 0.2)
