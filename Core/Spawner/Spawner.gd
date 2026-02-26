extends Node2D
class_name Spawner

const FLOWER = preload("uid://daiia8h0goc0c")
const POS_LIM_MIN: Vector2 = Vector2(110.0, 200.0)
const POS_LIM_MAX: Vector2 = Vector2(970.0, 200.0)

@export var flowers_container: Node2D
@export var spawn_controller: SpawnController

var flower: Flower = null
var next_flower_data: FlowerData

@onready var spawn_timer: Timer = $SpawnTimer
@onready var guide_stripe: Sprite2D = $GuideStripe


func _ready() -> void:
	pass


func _physics_process(_delta: float) -> void:
	update_position()


func _unhandled_input(event: InputEvent) -> void:
	if flower:
		if event.is_action_pressed("drop"):
			guide_stripe_visibility_on()
		elif event.is_action_released("drop"):
			drop_flower()
			guide_stripe_visibility_off()


func update_position() -> void:
	var cursor_position = get_global_mouse_position()
	cursor_position = cursor_position.clamp(POS_LIM_MIN, POS_LIM_MAX)
	global_position = cursor_position


func drop_flower() -> void:
	flower.reparent(flowers_container)
	flower.freeze = false
	flower.linear_velocity = Vector2(0, 250)
	flower.set_collision_mask_value(1, true)
	flower = null
	spawn_timer.start()
	AudioManager.play("drop")


func _on_spawn_timer_timeout() -> void:
	spawn_controller.set_new_flower_in_spawner()


func apply_flower_data(data: FlowerData) -> void:
	next_flower_data = data
	spawn_flower()


func spawn_flower() -> void:
	if !flower:
		var new_flower = FLOWER.instantiate() as Flower
		new_flower.flower_data = next_flower_data
		new_flower.position = Vector2.ZERO
		new_flower.set_collision_mask_value(1, false)
		add_child(new_flower)
		flower = new_flower


func guide_stripe_visibility_on() -> void:
	guide_stripe.show()


func guide_stripe_visibility_off() -> void:
	guide_stripe.hide()
