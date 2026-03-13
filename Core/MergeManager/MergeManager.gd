extends Node2D
class_name MergeManager

const SPIN_DIRECTION: Array = [-20.0, 20.0]

@export var flower_scene: PackedScene
@export var merge_effects_scene: PackedScene
@export var popup_scene: PackedScene
@export var flowers_container: Node2D

@onready var pop_up_container: Node2D = %PopUpContainer

var can_play_collide: bool = true


func _ready() -> void:
	SignalBus.flower_collide.connect(on_flower_collide)
	var warmer = merge_effects_scene.instantiate()
	warmer.queue_free()


func on_flower_collide(pos: Vector2, data: FlowerData, flower_a: RigidBody2D, flower_b: RigidBody2D) -> void:
	if flower_a.is_queued_for_deletion() or flower_b.is_queued_for_deletion():
		return

	if flower_a.flower_data.lvl == flower_b.flower_data.lvl:
		flower_a.queue_free()
		flower_b.queue_free()
		handle_merge_logic.call_deferred(pos, data)
	else:
		if not flower_a.has_collided or not flower_b.has_collided:
			if flower_a.linear_velocity.length() > 100 or flower_b.linear_velocity.length() > 100:
				AudioManager.play("collide")

				flower_a.has_collided = true
				flower_b.has_collided = true


func handle_merge_logic(pos: Vector2, data: FlowerData) -> void:
	var merge_effects = merge_effects_scene.instantiate() as MergeEffects
	add_child(merge_effects)
	merge_effects.global_position = pos

	if data.next_level != null:

		var new_flower = flower_scene.instantiate() as Flower
		new_flower.flower_data = data.next_level

		new_flower.global_position = pos
		flowers_container.add_child(new_flower)

		AudioManager.play("merge")
		new_flower.freeze = false
		new_flower.linear_velocity = Vector2(0, -1000)
		new_flower.angular_velocity = SPIN_DIRECTION.pick_random()

		merge_effects.setup(data)
		merge_pop_up_setup(pos, data)

		SignalBus.flower_merged.emit(pos, data.lvl, 0, 0)

	else:
		AudioManager.play("merge")
		merge_effects.last_lvl_setup(data)
		merge_pop_up_setup(pos, data)

		SignalBus.flower_merged.emit(pos, data.lvl, 0, 0)


func merge_pop_up_setup(pos, data) -> void:
	var merge_pop_up = popup_scene.instantiate() as MergePopUp
	pop_up_container.add_child(merge_pop_up)
	merge_pop_up.global_position = pos

	merge_pop_up.setup(data.score_value, data.coin_value)
