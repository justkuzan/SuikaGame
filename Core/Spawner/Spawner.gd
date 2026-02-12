extends Node2D

class_name Spawner

#signal flower_dropped

@export var test_flower_data: FlowerData

const FLOWER = preload("uid://daiia8h0goc0c")
const POS_LIM_MIN: Vector2 = Vector2(110.0, 200.0)
const POS_LIM_MAX: Vector2 = Vector2(970.0, 200.0)

@onready var spawn_timer: Timer = $SpawnTimer
var flower: Flower = null


func _ready() -> void:
	spawn_flower()


func _physics_process(delta: float) -> void:
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
	flower.linear_velocity = Vector2(0, 200)
	flower.reparent(get_parent())
	#flower_dropped.emit(flower)
	flower = null
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_flower()


func spawn_flower() -> void:
	if !flower:
		var new_flower = FLOWER.instantiate() as Flower
		new_flower.flower_data = test_flower_data
		new_flower.position = Vector2.ZERO
		add_child(new_flower)
		flower = new_flower
