extends Node
class_name ComboManager

@export var combo_popup_scene: PackedScene
@export var combo_phrases: Array[String] = []
@onready var combo_timer: Timer = $ComboTimer
@onready var pop_up_container: Node2D = %PopUpContainer

var combo_counter: int = 0
var combo_multiplier: int = 1


func _ready() -> void:
	SignalBus.flower_merged.connect(on_flower_merged)


func on_flower_merged(_pos: Vector2, _lvl: int, _score: int, _coins: int) -> void:
	if combo_timer.is_stopped():
		combo_counter = 1
	else:
		combo_counter += 1
		play_combo_audio()

	update_multiplier()
	combo_timer.start()
	SignalBus.combo_updated.emit(combo_counter, combo_multiplier)


func update_multiplier() -> void:
	if combo_counter < 2:
		combo_multiplier = 1
	else:
		combo_multiplier = (combo_counter / 2) * 2


func spawn_combo_popup_scene() -> void:
	var popup = combo_popup_scene.instantiate()
	pop_up_container.add_child(popup)
	#popup.global_position = screen_center

	var phrase_index = clampi(combo_counter - 2, 0, combo_phrases.size() - 1)
	var selected_text = combo_phrases[phrase_index]
	popup.setup(selected_text)


func _on_combo_timer_timeout() -> void:
	if combo_counter >= 2:
		spawn_combo_popup_scene()

	combo_counter = 0
	combo_multiplier = 1
	SignalBus.combo_updated.emit(combo_counter, combo_multiplier)


func play_combo_audio() -> void:
	var raw_pitch = 1.0 + (0.05 * (combo_counter - 2))
	AudioManager.combo.pitch_scale = clampf(raw_pitch, 1.0, 1.4)
	AudioManager.play("combo")
