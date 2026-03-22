extends Node

@onready var drop: AudioStreamPlayer = $Drop
@onready var collide: AudioStreamPlayer = $Collide
@onready var merge: AudioStreamPlayer = $Merge
@onready var combo: AudioStreamPlayer = $Combo
@onready var combo_end: AudioStreamPlayer = $ComboEnd
@onready var music: AudioStreamPlayer = $Music
@onready var ambience: AudioStreamPlayer = $Ambience


func play(sound_name: String) -> void:
	match sound_name:
		"drop":
			drop.pitch_scale = randf_range(0.9, 1.1)
			drop.play()

		"collide":
			collide.pitch_scale = randf_range(0.9, 1.1)
			collide.play()

		"merge":
			merge.play()

		"combo":
			combo.play()

		"combo_end":
			combo_end.play()

		"music":
			music.play()

		"ambience":
			ambience.play()
