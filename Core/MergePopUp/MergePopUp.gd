extends Node2D
class_name MergePopUp

@onready var counter_coins_h_box: HBoxContainer = $"Counter+Coins-HBox"
@onready var score_pop_up_label: Label = %"ScorePopUp-Label"
@onready var coins_pop_up_label: Label = %"CoinsPopUp-Label"


func _ready() -> void:
	animated_label(counter_coins_h_box)


func setup(score_val: int, coins_val: int) -> void:
	if score_pop_up_label:
		score_pop_up_label.text = "+" + str(score_val)

	if coins_pop_up_label:
		coins_pop_up_label.text = "+" + str(coins_val)


func animated_label(node: Control) -> void:
	node.modulate.a = 1.0

	var tween = get_tree().create_tween()
	var target_pos = node.position + Vector2(0, -150)

	tween.set_parallel(true)
	tween.tween_property(node, "position", target_pos, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "modulate:a", 0.0, 1.5)
	tween.finished.connect(queue_free)
