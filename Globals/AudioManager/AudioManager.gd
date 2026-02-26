extends Node

@onready var merge: AudioStreamPlayer = $Merge
@onready var drop: AudioStreamPlayer = $Drop


func play(sound_name: String) -> void:
	match sound_name:
		"merge":
			merge.pitch_scale = randf_range(0.9, 1.1)
			merge.play()

		"drop":
			drop.pitch_scale = randf_range(0.9, 1.1)
			drop.play()
