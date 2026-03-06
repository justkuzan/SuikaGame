extends Node

const FLOWER = preload("uid://daiia8h0goc0c")

@export var flower_array: Array[FlowerData]
@onready var flower_container: Node2D = $"../FlowerContainer"

@onready var delete_all: Button = $MarginContainer/MarginContainer/HBoxContainerBase/HBoxContainer2/DeleteAll
@onready var fill_10: Button = $MarginContainer/MarginContainer/HBoxContainerBase/HBoxContainer/Fill10


func _on_delete_all_pressed() -> void:
	var all_flowers: Array[Node] = flower_container.get_children()

	for single_flower in all_flowers:
		single_flower.queue_free()


func spawn_multiple_flowers(amount: int) -> void:
	for i in amount:
		AudioManager.play("drop")
		var new_flower = FLOWER.instantiate() as Flower
		flower_container.add_child(new_flower)

		var random_data = flower_array.pick_random()
		new_flower.flower_data = random_data
		new_flower.update_flower()

		new_flower.position = Vector2(randf_range(100, 500), randf_range(600, 700))
		new_flower.set_collision_mask_value(1, true)

		new_flower.freeze = false


func _on_fill_10_pressed() -> void:
	spawn_multiple_flowers(10)


func _on_fill_30_pressed() -> void:
	spawn_multiple_flowers(30)


func _on_fill_50_pressed() -> void:
	spawn_multiple_flowers(50)
