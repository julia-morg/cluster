extends Node

var main : MainScene = null

signal inited

var screen_manager : ScreenManager = null
var save_manager : SaveManager = null
var sound_manager : SoundManager = null
var settings : Settings = null
var player_data: PlayerData = null
const SAVE_PATH: String = "user://save_file.dat"


func _ready() -> void:
	save_manager = SaveManager.new()
	add_child(save_manager)
	
	settings = Settings.new()
	add_child(settings)
	
	player_data = PlayerData.new()
	add_child(player_data)
	
	_load_settings()
	
	screen_manager = ScreenManager.new()
	add_child(screen_manager)

	sound_manager = SoundManager.new()
	add_child(sound_manager)
	
	
	
	await get_tree().create_timer(2.0).timeout
	inited.emit()

func get_meta_coins() -> int:
	return 666

func _load_settings() -> void:
	settings.set_sound(save_manager.get_sound_state())
	settings.set_vibro(save_manager.get_vibro_state())
	settings.set_language(save_manager.get_lang())
	settings.sound_changed.connect(save_manager.save_data)
	settings.vibro_changed.connect(save_manager.save_data)
	settings.language_changed.connect(save_manager.save_data)
	player_data.set_coins(save_manager.get_coins())
	player_data.set_player_name(save_manager.get_player_name())
	player_data.set_level(save_manager.get_level())
	player_data.level_changed.connect(save_manager.save_data)
	player_data.name_changed.connect(save_manager.save_data)
	player_data.coins_changed.connect(save_manager.save_data)
	

func _get_ui_parent() -> Node:
	var current_scene: Node = get_tree().current_scene
	if current_scene is Control:
		return current_scene
	var ui_root: Node = current_scene.get_node_or_null("UIRoot")
	if ui_root and ui_root is Control:
		return ui_root
	return current_scene


func _on_language_changed() -> void:
	save_manager.save_data()


func _on_meta_coins_changed() -> void:
	save_manager.save_data()

	var save_dict: Dictionary = {
		"settings_sound_on": settings.get_sound_volume(),
		"settings_vibro_on": settings.get_music_volume(),
		"settings_language": settings.get_language(),
	}
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(save_dict)
		file.close()
