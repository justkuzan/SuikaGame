extends Node2D
class_name Level


func _ready() -> void:
	pass

#Пауза: В инспекторе узла YandexManager (если он у тебя в Autoload) убедись,
#что Process -> Mode стоит на Always. Иначе, когда игра встанет на паузу,
#сам менеджер тоже "замерзнет" и не сможет принять сигнал о закрытии рекламы.

#Вызов рекламы: Теперь в любом месте игры (например, в Level.gd при проигрыше или раз в 5 минут) ты можешь просто вызвать:
#YandexManager.show_fullscreen_ad()
