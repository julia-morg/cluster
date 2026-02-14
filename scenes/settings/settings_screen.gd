extends Node2D
class_name SettingsScreen

signal back_pressed

@onready var close_button = $UIRoot/Panel/Exit
@onready var language_spin: SBSpinButton = $UIRoot/Panel/VBoxContainer/Panel/LanguageSpinButton
@onready var sound_check: CheckButton = $UIRoot/Panel/VBoxContainer/SoundCheck
@onready var vibro_check: CheckButton = $UIRoot/Panel/VBoxContainer/VibroCheck


func _ready() -> void:
	close_button.pressed.connect(back_pressed.emit)
	sound_check.set_pressed_no_signal(G.settings.get_sound())
	vibro_check.set_pressed_no_signal(G.settings.get_vibro())
	
	language_spin.selected = _language_code_to_index(G.settings.language)
	G.settings.sound_changed.connect(_on_sound_changed)
	G.settings.vibro_changed.connect(_on_vibro_changed)
	G.settings.language_changed.connect(_on_language_changed)

func _on_sound_changed():
	sound_check.set_pressed_no_signal(G.settings.get_sound())

func _on_vibro_changed():
	vibro_check.set_pressed_no_signal(G.settings.get_vibro())


func _on_language_changed():
	language_spin.selected = _language_code_to_index(G.settings.language)

func _language_code_to_index(code: String) -> int:
	match code.to_lower():
		"ru", "rus", "russian":
			return G.settings.LANG_RUS
		"en", "eng", "english":
			return G.settings.LANG_ENG
		_:
			return G.settings.LANG_ENG


func _language_index_to_code(index: int) -> String:
	match index:
		G.settings.LANG_RUS:
			return "ru"
		G.settings.LANG_ENG:
			return "en"
		_:
			return "en"

func _on_sound_check_toggled(toggled_on: bool) -> void:
	G.settings.set_sound(toggled_on)


func _on_vibro_check_toggled(toggled_on: bool) -> void:
	G.settings.set_vibro(toggled_on)

func _on_language_spin_button_item_selected(index: int) -> void:
	if index == -1:
		return
	G.settings.set_language(_language_index_to_code(index))
	
