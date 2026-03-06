extends Node2D
class_name SpawnController

@export var drops_for_lvl_1: int
@export var drops_for_lvl_2: int
@export var drops_for_lvl_3: int
@export var flower_pool: Array[FlowerData] = []
@export var spawner: Spawner

var total_drops: int


func _ready() -> void:
	set_new_flower_in_spawner()


func set_new_flower_in_spawner():
	var spawn_selection = spawn_selection_flower()
	spawner.apply_flower_data(spawn_selection)


func spawn_selection_flower() -> FlowerData:
	total_drops += 1

	if total_drops <= drops_for_lvl_1:
		return flower_pool[0]
	elif total_drops <= drops_for_lvl_2:
		var roll: int = randi_range(0, 1)
		return flower_pool[roll]
	elif total_drops <= drops_for_lvl_3:
		var roll: int = randi_range(0, 2)
		return flower_pool[roll]
	else:
		return spawn_drop_rate_calculation()


func spawn_drop_rate_calculation() -> FlowerData:
	var total_rate: float = 0.0

	for flower in flower_pool:
		total_rate += flower.drop_rate

	var roll: float = randf_range(0.0, total_rate)

	for flower in flower_pool:
		roll -= flower.drop_rate

		if roll <= 0:
			return flower

	return flower_pool[0]
