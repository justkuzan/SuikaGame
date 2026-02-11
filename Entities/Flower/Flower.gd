extends RigidBody2D

class_name Flower

@export var flower_data: FlowerData

const DEFAULT_SPRITE = preload("uid://bmokhxpn5877l")

@onready var flower_sprite: Sprite2D = $FlowerSprite
@onready var flower_collision: CollisionShape2D = $FlowerCollision


func _ready() -> void:
	if flower_data and flower_data.sprite:
		flower_sprite.texture = flower_data.sprite
	else:
		flower_sprite.texture = DEFAULT_SPRITE

	if flower_data and flower_collision.shape is CircleShape2D:
		flower_collision.shape.radius = flower_data.collision_radius

	else:
		print("There is no shape on Flower!")
