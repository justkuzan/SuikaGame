extends Node

@onready var drop: AudioStreamPlayer = $Drop
@onready var collide: AudioStreamPlayer = $Collide
@onready var merge: AudioStreamPlayer = $Merge
@onready var coin: AudioStreamPlayer = $Coin
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
			#merge.pitch_scale = randf_range(0.9, 1.1)
			merge.play()

		"coin":
			#coin.pitch_scale = randf_range(0.9, 1.1)
			#get_tree().create_tween().tween_callback(coin.play).set_delay(0.15)
			coin.play()

		"music":
			music.play()

		"ambience":
			ambience.play()
