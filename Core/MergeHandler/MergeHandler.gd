extends Node2D
class_name MergeHandler

const FLOWER = preload("uid://daiia8h0goc0c")
const MERGE_EFFECTS = preload("uid://dvk3rdpl0y03s")
const SPIN_DIRECTION: Array = [-20.0, 20.0]

@export var flowers_container: Node2D


func _ready() -> void:
	SignalBus.on_flower_collide.connect(on_flower_collide, CONNECT_DEFERRED)


func on_flower_collide(position: Vector2, data: FlowerData, flower_a: RigidBody2D, flower_b: RigidBody2D) -> void:
	if flower_a.is_queued_for_deletion() or flower_b.is_queued_for_deletion():
		return

	flower_a.queue_free()
	flower_b.queue_free()
	if data.next_level != null:

		var new_flower = FLOWER.instantiate() as Flower
		new_flower.flower_data = data.next_level
		new_flower.freeze = false
		flowers_container.add_child(new_flower)
		new_flower.global_position = position

		new_flower.linear_velocity = Vector2(0, -700)
		new_flower.apply_torque_impulse(SPIN_DIRECTION.pick_random())

		var merge_effects = MERGE_EFFECTS.instantiate() as MergeEffects
		add_child(merge_effects)
		merge_effects.global_position = position
		merge_effects.setup(data)

		AudioManager.play("merge")

	if data.next_level == null:
		var merge_effects = MERGE_EFFECTS.instantiate() as MergeEffects
		add_child(merge_effects)
		merge_effects.global_position = position
		merge_effects.last_lvl_setup(data)

		AudioManager.play("merge")
