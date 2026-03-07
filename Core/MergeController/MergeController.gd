extends Node2D
class_name MergeController

const FLOWER = preload("uid://daiia8h0goc0c")
const MERGE_EFFECTS = preload("uid://dvk3rdpl0y03s")
const SPIN_DIRECTION: Array = [-20.0, 20.0]

@export var flowers_container: Node2D
@onready var merge_queue_timer: Timer = $"MergeQueue-Timer"

var merge_queue: Array


func _ready() -> void:
	SignalBus.flower_collide.connect(on_flower_collide)


# IMPORTANT: Here we not only calculate how the flowers are collided,
# but also put them into an array to collide them according to a timer
# This is not critical for the logic, but it affects the juiciness.
func on_flower_collide(pos: Vector2, data: FlowerData, flower_a: RigidBody2D, flower_b: RigidBody2D) -> void:
	if flower_a.is_queued_for_deletion() or flower_b.is_queued_for_deletion():
		return

	var merge_flowers_dict = {
		"flower_a": flower_a,
		"flower_b": flower_b,
		"merge_position": pos,
		"new_flower_data": data
	}

	merge_queue.append(merge_flowers_dict)
	if merge_queue_timer.is_stopped(): merge_queue_timer.start()

	flower_a.set_deferred("freeze", true)
	flower_b.set_deferred("freeze", true)
	flower_a.set_deferred("collision_layer", 0)
	flower_b.set_deferred("collision_layer", 0)


func _on_merge_queue_timer_timeout() -> void:
	if merge_queue.size() > 0:
		var item = merge_queue.pop_front()

		if is_instance_valid(item["flower_a"]):
			item["flower_a"].queue_free()

		if is_instance_valid(item["flower_b"]):
			item["flower_b"].queue_free()

			handle_merge_logic.call_deferred(item["merge_position"], item["new_flower_data"])
			if merge_queue.size() > 0:
				merge_queue_timer.start()


func handle_merge_logic(pos: Vector2, data: FlowerData) -> void:
	var merge_effects = MERGE_EFFECTS.instantiate() as MergeEffects
	add_child(merge_effects)
	merge_effects.global_position = pos

	if data.next_level != null:

		var new_flower = FLOWER.instantiate() as Flower
		new_flower.flower_data = data.next_level

		new_flower.global_position = pos
		flowers_container.add_child(new_flower)

		AudioManager.play("merge")
		new_flower.freeze = false
		new_flower.linear_velocity = Vector2(0, -1000)
		new_flower.angular_velocity = SPIN_DIRECTION.pick_random()

		merge_effects.setup(data)

	else:
		AudioManager.play("merge")
		merge_effects.last_lvl_setup(data)
