extends Node2D
class_name MergeEffects

@onready var petal_particles: CPUParticles2D = $PetalParticles


func setup(data: FlowerData) -> void:
	if data.petal_sprite:
		petal_particles.texture = data.petal_sprite

	petal_particles.restart()


func last_lvl_setup(data: FlowerData) -> void:
	if data.petal_sprite:
		petal_particles.texture = data.petal_sprite

		#settings for last lvl effects
		petal_particles.scale_amount_min = 1
		petal_particles.scale_amount_max = 1
		petal_particles.amount = 30
		petal_particles.lifetime = 1.2
		petal_particles.angular_velocity_min = -270
		petal_particles.angular_velocity_max = 270
		petal_particles.initial_velocity_min = 500
		petal_particles.initial_velocity_max = 1000

	petal_particles.restart()


func _on_leaves_particles_finished() -> void:
	if not petal_particles.emitting:
		queue_free()
