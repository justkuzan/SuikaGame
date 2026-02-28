extends Node

# Сигналы для других систем (например, для музыки)
signal ad_started
signal ad_finished

var window = null
var _callback_ref = null # Ссылка, чтобы GC не удалил коллбэк


func _ready():
	# Чтобы скрипт работал, когда игра на паузе
	process_mode = Node.PROCESS_MODE_ALWAYS

	if OS.has_feature("web"):
		window = JavaScriptBridge.get_interface("window")
		# Создаем мост для связи с JS
		_callback_ref = JavaScriptBridge.create_callback(_js_callback)
		# Регистрируем Godot-объект в браузере
		if window and window.has_method("registerGodotHandler"):
			window.registerGodotHandler(_callback_ref)


# Единая точка входа для всех вызовов из браузера
func _js_callback(args):
	if args.size() > 0:
		var method_name = args[0]

		match method_name:
			"on_ad_started":
				_on_ad_started()

			"on_ad_finished":
				_on_ad_finished()


func _on_ad_started():
	get_tree().paused = true
	# Глушим звук полностью через Master-шину (индекс 0)
	AudioServer.set_bus_mute(0, true)
	ad_started.emit()
	print("SDK: Реклама началась, игра на паузе")


func _on_ad_finished():
	# Возвращаем звук и снимаем паузу
	AudioServer.set_bus_mute(0, false)
	get_tree().paused = false
	ad_finished.emit()
	print("SDK: Реклама окончена, игра возобновлена")


# Метод, который ты вызываешь из игры для показа рекламы
func show_fullscreen_ad():
	if window and window.has_method("showAd"):
		window.showAd()
	else:
		print("SDK: Вызов рекламы невозможен (не в браузере или метод не найден)")
