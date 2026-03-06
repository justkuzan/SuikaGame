extends Node

signal flower_collide(
	position: Vector2,
	data: FlowerData,
	flower_a: RigidBody2D,
	flower_b: RigidBody2D
	)

signal debug_mode_changed(bool)
