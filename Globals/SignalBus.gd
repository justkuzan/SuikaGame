extends Node

signal flower_collide(
	position: Vector2,
	data: FlowerData,
	flower_a: RigidBody2D,
	flower_b: RigidBody2D
	)

signal debug_mode_changed(bool)

signal flower_merged(pos: Vector2, lvl: int, score: int, coins: int)

signal score_changed(value)

signal high_score_changed(value)

signal coins_changed(value)

signal combo_updated(pos: Vector2, combo_count: int, combo_multiplier: int)
