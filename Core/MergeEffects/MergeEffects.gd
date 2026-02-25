extends Node2D
class_name MergeEffects

@onready var petal_particles: CPUParticles2D = $PetalParticles


func setup(data: FlowerData) -> void:
	if data.petal_sprite:
		petal_particles.texture = data.petal_sprite

	petal_particles.restart()


func _on_leaves_particles_finished() -> void:
	if not petal_particles.emitting:
		queue_free()
