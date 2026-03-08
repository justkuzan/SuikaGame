extends Resource
class_name FlowerData

@export_group("Exp and Economy")
@export var lvl: int = 1
@export var score_value: int = 0
@export var coin_value: int = 0

@export_group("Physics")
@export var mass: float = 1.0
@export var collision_radius: float = 64.0

@export_group("Drop Rate")
@export var drop_rate: float = 0.0

@export_group("Resourses")
@export var next_level: FlowerData
@export var sprite: Texture2D
@export var petal_sprite: Texture2D

#Flowers drop percentage table:
#1 lvl - 40
#2 lvl - 30
#3 lvl - 20
#4 lvl - 10
#5 lvl - 3
