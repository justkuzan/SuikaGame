extends Node2D
class_name Level

@onready var debug_manager: CanvasLayer = $DebugManager

var is_debug_enabled: bool = false


func _ready() -> void:
	pass


func _input(event: InputEvent) -> void:
	if debug_manager and event.is_action_pressed("debug_panel"):
		debug_manager.visible = !debug_manager.visible
		is_debug_enabled = debug_manager.visible
		SignalBus.debug_mode_changed.emit(is_debug_enabled)
