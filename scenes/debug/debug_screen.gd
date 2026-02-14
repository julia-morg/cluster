extends Node2D

@onready var settings_button: TextureButton = $UIRoot/SettingsButton
@onready var story_button: Button = $UIRoot/CenterContainer/VBoxContainer/Story
@onready var infinite_run_button: Button = $UIRoot/CenterContainer/VBoxContainer/InfiniteRun
@onready var coins_label: Currency = $UIRoot/MetaCoins/MetaCoinsLabel


func _ready() -> void:
	story_button.pressed.connect(G.screen_manager.start_story)
	infinite_run_button.pressed.connect(G.screen_manager.start_infinite_run)
	_set_meta_coins_view(G.get_meta_coins())
	G.start_game()
	G.sound_manager.play_music(G.sound_manager.MUSIC_MAIN, true)


func _on_rewarded_close(success: bool) -> void:
	if not success:
		G.screen_manager.show_message("Close ads without reward", "")


func _on_fullscreen_close(success: bool) -> void:
	if success:
		G.screen_manager.show_message("Реклама просмотрена", "Спасибо!")
	else:
		G.screen_manager.show_message("Реклама закрыта без просмотра", "")


func _on_plus_button_pressed() -> void:
	_set_meta_coins_view(G.add_meta_coins(100))


func _on_minus_button_pressed() -> void:
	_set_meta_coins_view(G.consume_meta_coins(200))


func _set_meta_coins_view(meta_coins: int) -> void:
	coins_label.text = str(meta_coins)


func _on_log_pressed() -> void:
	G.sound_manager.play_sound(G.sound_manager.SOUND_TUN, false)
	G.start_gameplay()
	var info: String = ''
	info += "\nname local: " + str(G.player_data.name)
	info += "\nmeta_coins local: " + str(G.player_data.gold)
	info += "\nlang local: " + str(G.settings.get_language())
	info += "\nmusic local: " + str(G.settings.get_music_volume())
	info += "\nsound local: " + str(G.settings.get_sound_volume())
	G.screen_manager.show_message(info, "")


func _on_fullscreen_ad_pressed() -> void:
	G.show_fullscreen_ad(_on_fullscreen_close)


func _on_rewarded_ad_pressed() -> void:
	G.show_reward_ad(_on_plus_button_pressed, _on_rewarded_close)
