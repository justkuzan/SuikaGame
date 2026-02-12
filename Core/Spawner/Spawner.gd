extends Node2D

class_name Spawner

const POS_LIM_MIN: Vector2 = Vector2(110.0, 200.0)
const POS_LIM_MAX: Vector2 = Vector2(970.0, 200.0)

@onready var flower: Flower = $Flower
@onready var timer: Timer = $Timer


func _process(delta: float) -> void:
	var cursor_position = get_global_mouse_position()
	cursor_position = cursor_position.clamp(POS_LIM_MIN, POS_LIM_MAX)
	global_position = cursor_position


func _unhandled_input(event: InputEvent) -> void:
	if flower and event.is_action_pressed("drop"):
		print("DROP!")
		flower.freeze = false
		flower.reparent(get_parent())
		flower = null
		timer.start()
