extends Node
class_name SaveManager

const SAVE_PATH: String = "user://save_file.dat"
const VAL_COINS = "coins"
const VAL_NAME = "player_name"
const VAL_LEVEL = "level"
const VAL_SETTING_SOUND = "settings_sound"
const VAL_SETTING_VIBRO = "settings_vibro"
const VAL_SETTING_LANG = "settings_lang"

var save: Dictionary

func _ready() -> void:
	load_data()

func get_coins() -> int:
	return save[VAL_COINS]
	
func get_level() -> int:
	return save[VAL_LEVEL]
	
func get_player_name() -> String:
	return save[VAL_NAME]
	
func get_lang()->String:
	return save[VAL_SETTING_LANG]
	
func get_sound_state() -> bool:
	return save[VAL_SETTING_SOUND]
		
func get_vibro_state() -> bool:
	return save[VAL_SETTING_VIBRO]

func _generate_player_name() -> String:
	return "Player%d" % randi_range(100000, 999999)




func load_data() -> Dictionary:
	if save != {}:
		return save
	save = {
		VAL_NAME: _generate_player_name(),
		VAL_LEVEL: 1,
		VAL_COINS: 150,
		VAL_SETTING_SOUND: false,
		VAL_SETTING_VIBRO: true,
		VAL_SETTING_LANG: "en",
	}

	if FileAccess.file_exists(SAVE_PATH):
		var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.READ)
		if file:
			var content = file.get_var()
			file.close()
			if content:
				for key in content:
					save[key] = content[key]

	return save


func save_data() -> void:
	var save_dict: Dictionary = {
		VAL_SETTING_SOUND: G.settings.get_sound(),
		VAL_SETTING_VIBRO: G.settings.get_vibro(),
		VAL_SETTING_LANG: G.settings.get_language(),
		VAL_COINS: G.player_data.get_coins(),
		VAL_NAME: G.player_data.get_player_name(),
		VAL_LEVEL: G.player_data.get_level(),
	}
	var file: FileAccess = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(save_dict)
		file.close()
