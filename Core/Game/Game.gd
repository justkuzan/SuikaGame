extends Node2D

class_name Game

func _ready() -> void:
	YandexSDK.init_game()
	YandexSDK.game_ready()
	YandexSDK.show_interstitial_ad()

#Все что ниже (что касается яндекса) можно будет закинуть непосредственно в Игру (при запуске уровня)
	get_viewport().focus_entered.connect(focus_in)
	get_viewport().focus_entered.connect(focus_out)


func focus_in() -> void:
	YandexSDK.gameplay_started()


func focus_out() -> void:
	YandexSDK.gameplay_stopped()
