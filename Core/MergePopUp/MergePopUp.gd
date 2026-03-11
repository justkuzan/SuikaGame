extends Node2D
class_name MergePopUp

@onready var counter_coins_h_box: HBoxContainer = $"Counter+Coins-HBox"


func _ready() -> void:
	animated_label(counter_coins_h_box)


func animated_label(node: Control) -> void:
	node.modulate.a = 1.0

	var tween = get_tree().create_tween()
	var target_pos = node.position + Vector2(0, -100)

	tween.set_parallel(true)
	tween.tween_property(node, "position", target_pos, 3.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(node, "modulate:a", 0.0, 3.0)
	tween.finished.connect(queue_free)
