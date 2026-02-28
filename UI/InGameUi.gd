extends CanvasLayer

@onready var button: Button = $InGameUI/MarginContainer/HBoxContainer/Button


func music_switch() -> void:
	pass


func _on_button_toggled(toggled_on: bool) -> void:
	#if toggled_on:
		#AudioManager.music.stop()
#
	#if toggled_on == false:
		#AudioManager.music.play()

	
	AudioManager.music.stream_paused = toggled_on
