extends Node2D
class_name ComboPopUp

@onready var combo_pop_up_margin: MarginContainer = $"ComboPopUp-Margin"


func _ready() -> void:
	combo_pop_up_margin.modulate.a = 1.0
	combo_pop_up_margin.scale = Vector2(0.8, 0.8)

	var tween = get_tree().create_tween()
	var target_pos = combo_pop_up_margin.position + Vector2(0, -150)

	tween.set_parallel(true)
	tween.tween_property(combo_pop_up_margin, "position", target_pos, 1.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(combo_pop_up_margin, "modulate:a", 0.0, 1.5)

	tween.set_parallel(false)
	tween.tween_property(combo_pop_up_margin, "scale", Vector2(1.2, 1.2), 0.3)
	tween.tween_property(combo_pop_up_margin, "scale", Vector2(1.0, 1.0), 0.2)

	tween.finished.connect(queue_free)
