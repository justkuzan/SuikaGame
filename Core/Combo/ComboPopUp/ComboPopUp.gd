extends Node2D
class_name ComboPopUp

@onready var combo_pop_up_label: Label = $"ComboPopUp-Label"


func _ready() -> void:
	combo_pop_up_label.modulate.a = 1.0
	combo_pop_up_label.scale = Vector2(0.75, 0.75)

	var tween = get_tree().create_tween()
	var target_pos = combo_pop_up_label.position + Vector2(0, -200)

	tween.set_parallel(true)
	tween.tween_property(combo_pop_up_label, "position", target_pos, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(combo_pop_up_label, "modulate:a", 0.0, 2.0)

	#tween.set_parallel(true)
	tween.tween_property(combo_pop_up_label, "scale", Vector2(1.0, 1.0), 2.0)
	#tween.tween_property(combo_pop_up_margin, "scale", Vector2(1.0, 1.0), 2.0)

	tween.finished.connect(queue_free)
