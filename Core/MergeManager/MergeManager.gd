extends Node2D
class_name MergeManager

const FLOWER = preload("uid://daiia8h0goc0c")
const MERGE_EFFECTS = preload("uid://dvk3rdpl0y03s")
const SPIN_DIRECTION: Array = [-20.0, 20.0]

@export var flowers_container: Node2D


func _ready() -> void:
	SignalBus.flower_collide.connect(on_flower_collide)
	var warmer = MERGE_EFFECTS.instantiate()
	warmer.queue_free()


func on_flower_collide(pos: Vector2, data: FlowerData, flower_a: RigidBody2D, flower_b: RigidBody2D) -> void:
	if flower_a.is_queued_for_deletion() or flower_b.is_queued_for_deletion():
		return

	flower_a.queue_free()
	flower_b.queue_free()

	handle_merge_logic.call_deferred(pos, data)


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
		merge_effects.merge_pop_up_setup(data)

		SignalBus.flower_merged.emit(pos, data.lvl)

	else:
		AudioManager.play("merge")
		merge_effects.last_lvl_setup(data)
		merge_effects.merge_pop_up_setup(data)

		SignalBus.flower_merged.emit(pos, data.lvl)
