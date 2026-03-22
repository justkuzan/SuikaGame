extends Node
class_name ComboManager

@export var balance: GameBalance

@export var min_combo_threshold: int = 3
@export var combo_popup_scene: PackedScene
@export var combo_phrases: Array[String] = []
@onready var combo_timer: Timer = $ComboTimer
@onready var pop_up_container: Node2D = %PopUpContainer

var combo_counter: int = 0
var combo_multiplier: int = 1

#Пусть ComboManager сам решает, достаточно ли высоко поднялся счетчик,
#и посылает в сигнале не только цифру, но и «состояние» (например, флаг is_active).
#Ну и нам надо чтобы он посылал еще вектор (посмотреть на Мердж Поп Ап)


func _ready() -> void:
	SignalBus.flower_merged.connect(on_flower_merged)


func on_flower_merged(_pos: Vector2, _lvl: int, _score: int, _coins: int) -> void:
	if combo_timer.is_stopped():
		combo_counter = 1
	else:
		combo_counter += 1

	if combo_counter >= min_combo_threshold:
		play_combo_audio()

	update_multiplier()
	combo_timer.start()
	SignalBus.combo_updated.emit(combo_counter, combo_multiplier)


func update_multiplier() -> void:
	if combo_counter < min_combo_threshold:
		combo_multiplier = 1
	else:
		combo_multiplier = ((combo_counter - min_combo_threshold) / 2 + 1) * 2


func spawn_combo_popup_scene() -> void:
	var popup = combo_popup_scene.instantiate()
	pop_up_container.add_child(popup)
	#popup.global_position = screen_center

	var phrase_index = clampi(combo_counter - min_combo_threshold, 0, combo_phrases.size() - 1)
	var selected_text = combo_phrases[phrase_index]
	popup.setup(selected_text)


func _on_combo_timer_timeout() -> void:
	if combo_counter >= min_combo_threshold:
		spawn_combo_popup_scene()
		#AudioManager.play("combo_end")

	combo_counter = 0
	combo_multiplier = 1
	SignalBus.combo_updated.emit(combo_counter, combo_multiplier)


func play_combo_audio() -> void:
	var raw_pitch = 1.0 + (0.05 * (combo_counter - min_combo_threshold))
	AudioManager.combo.pitch_scale = clampf(raw_pitch, 1.0, 1.4)
	AudioManager.play("combo")
