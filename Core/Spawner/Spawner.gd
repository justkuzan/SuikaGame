extends Node2D
class_name Spawner

const FLOWER = preload("uid://daiia8h0goc0c")
const POS_LIM_MIN: Vector2 = Vector2(110.0, 200.0)
const POS_LIM_MAX: Vector2 = Vector2(970.0, 200.0)

@export var flower_pool: Array[FlowerData] = []
@export var flowers_container: Node2D

var flower: Flower = null

@onready var spawn_timer: Timer = $SpawnTimer
@onready var guide_stripe: Sprite2D = $GuideStripe


func _ready() -> void:
	spawn_flower()


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
	flower.linear_velocity = Vector2(0, 150)
	flower.set_collision_mask_value(1, true)
	flower = null
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	spawn_flower()


func spawn_drop_rate_calculation() -> FlowerData:
	var total_rate: float = 0.0

	for i in flower_pool:
		total_rate += i.drop_rate

	var roll: float = randf_range(0.0, total_rate)

	for i in flower_pool:
		roll -= i.drop_rate

		if roll <= 0:
			return i

	return null


func spawn_flower() -> void:
	if !flower:
		var random_data = spawn_drop_rate_calculation()

		if random_data:
			var new_flower = FLOWER.instantiate() as Flower
			new_flower.flower_data = random_data
			new_flower.position = Vector2.ZERO
			new_flower.set_collision_mask_value(1, false)
			add_child(new_flower)
			flower = new_flower


func guide_stripe_visibility_on() -> void:
	#guide_stripe.modulate.a = 0.0
	guide_stripe.show()

	#var tween = create_tween()
	#tween.tween_property(guide_stripe, "modulate:a", 1.0, 0.2).set_trans(Tween.TRANS_SINE)


func guide_stripe_visibility_off() -> void:
	#guide_stripe.modulate.a = 1.0
	guide_stripe.hide()

	#var tween = create_tween()
	#tween.tween_property(guide_stripe, "modulate:a", 0.0, 0.1).set_trans(Tween.TRANS_SINE)
