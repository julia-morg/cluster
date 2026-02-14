extends Node
class_name ScreenManager

var settings: SettingsScreen = null
var message: MessageScreen   = null
var prev_screen: PackedScene = SC_MENU

var SC_SETTINGS = preload("res://scenes/settings/settings_screen.tscn")
var SC_MESSAGE = preload("res://scenes/message/message.tscn")
var SC_MENU = preload("res://scenes/menu/menu.tscn")
var SC_LOADER = preload("res://scenes/loader/loader.tscn")
var SC_MAIN = preload("res://scenes/main/main.tscn")



func open_settings():
	settings.reparent(G.main.active_scene)
	settings.z_index = 1000
	settings.show()


func show_message(title: String, subtitle: String) -> void:
	message.reparent(G.main.active_scene)
	message.set_title(title)
	message.set_subtitle(subtitle)
	message.z_index = 1000
	message.show()

func show_loader():
	G.main.change_to(SC_LOADER)

func main_menu():
	G.main.change_to(SC_MENU)


func return_to_prev():
	G.main.change_to(prev_screen)


func start_story():
	prev_screen = SC_MAIN
	G.main.change_to(SC_LOADER)


func start_level(level_n: int):
	#G.main.change_to(Ref.SC_MAIN)
	G.main.active_scene.set_level(level_n)


func end_level(msg: String):
	G.main.change_to(SC_MESSAGE)
	G.main.active_scene.set_message(msg)


func end_game():
	G.main.change_to(SC_MESSAGE)
	G.main.active_scene.set_message("Конец (?)")


func _ready() -> void:
	settings = SC_SETTINGS.instantiate()
	settings.hide()
	settings.back_pressed.connect(_close_settings)
	add_child(settings)

	message = SC_MESSAGE.instantiate()
	message.hide()
	message.back_pressed.connect(_close_message)
	add_child(message)


func _close_settings():
	settings.hide()
	settings.reparent(self)


func _close_message():
	message.hide()
	message.reparent(self)
