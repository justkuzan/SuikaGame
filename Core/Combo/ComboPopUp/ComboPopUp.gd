extends CanvasLayer
class_name ComboPopUp

@onready var combo_pop_up_label: Label = $"ComboPopUp-Label"


func _ready() -> void:
	combo_pop_up_label.modulate.a = 1.0
	combo_pop_up_label.scale = Vector2(0.9, 0.9)

	var tween = get_tree().create_tween()
	var target_pos = combo_pop_up_label.position + Vector2(0, -250)

	tween.set_parallel(true)
	tween.tween_property(combo_pop_up_label, "position", target_pos, 2.5).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property(combo_pop_up_label, "modulate:a", 0.0, 2)

	#tween.set_parallel(true)
	tween.tween_property(combo_pop_up_label, "scale", Vector2(1.5, 1.5), 2.5)

	tween.finished.connect(queue_free)


func setup(combo_string: String):
	combo_pop_up_label.text = combo_string
