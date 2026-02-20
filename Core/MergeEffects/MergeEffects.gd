extends Node2D
class_name MergeEffects

@onready var leaves_particles: CPUParticles2D = $LeavesParticles
@onready var petal_particles: CPUParticles2D = $PetalParticles


func setup(data: FlowerData) -> void:
	if data.petal_sprite:
		petal_particles.texture = data.petal_sprite

	leaves_particles.restart()
	petal_particles.restart()
	#leaves_particles.emitting = true
	#petal_particles.emitting = true


func _on_leaves_particles_finished() -> void:
	if not petal_particles.emitting:
		queue_free()
