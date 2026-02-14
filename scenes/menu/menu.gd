extends Node2D

@onready var settings_button: TextureButton = $UIRoot/SettingsButton
@onready var story_button: Button = $UIRoot/CenterContainer/VBoxContainer/Story
@onready var coins_label: Currency = $UIRoot/MetaCoins/MetaCoinsLabel


func _ready() -> void:
	story_button.pressed.connect(G.screen_manager.start_story)
	_set_meta_coins_view(G.get_meta_coins())
	#G.start_game()


func _set_meta_coins_view(meta_coins: int) -> void:
	coins_label.text = str(meta_coins)


func _on_log_pressed() -> void:
	G.sound_manager.play_sound(G.sound_manager.SOUND_TUN, false)
	var info: String = ''
	info += "\nname local: " + str(G.player_data.get_player_name())
	info += "\ncoins local: " + str(G.player_data.get_coins())
	info += "\nlang local: " + str(G.settings.get_language())
	info += "\nsound local: " + str(G.settings.get_sound())
	info += "\nvibro local: " + str(G.settings.get_vibro())
	G.screen_manager.show_message(info, "")
