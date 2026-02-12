extends Node2D

class_name Spawner

#signal flower_dropped

const FLOWER = preload("uid://daiia8h0goc0c")
const POS_LIM_MIN: Vector2 = Vector2(110.0, 200.0)
const POS_LIM_MAX: Vector2 = Vector2(970.0, 200.0)

@onready var flower: Flower = $Flower
@onready var spawn_timer: Timer = $SpawnTimer


func _process(delta: float) -> void:
	update_position()


func _unhandled_input(event: InputEvent) -> void:
	if flower and event.is_action_released("drop"):
		drop_flower()


func update_position() -> void:
	var cursor_position = get_global_mouse_position()
	cursor_position = cursor_position.clamp(POS_LIM_MIN, POS_LIM_MAX)
	global_position = cursor_position


func drop_flower() -> void:
	flower.freeze = false
	flower.reparent(get_parent())
	#flower_dropped.emit(flower)
	flower = null
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_flower()


func spawn_flower() -> void:
	if !flower:
		var new_flower = FLOWER.instantiate()
		add_child(new_flower)
		new_flower.position = Vector2.ZERO
		flower = new_flower
	
	
	
	
	
