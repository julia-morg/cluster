extends Node
class_name Settings

var vibro_on: bool = true
var sound_on: bool = false
var is_sound_muted: bool = false

const LANG_RUS: int         = 0
const LANG_ENG: int         = 1
const ALL_LANGS: Dictionary = {LANG_RUS: 'ru', LANG_ENG: 'en'}
var language: String        = ''

signal sound_changed
signal vibro_changed
signal language_changed

func get_sound() -> bool:
	return sound_on


func get_vibro() -> bool:
	return vibro_on


func get_language() -> String:
	return language


func set_vibro(is_on: bool) -> bool:
	if vibro_on != is_on:
		vibro_on = is_on
		vibro_changed.emit()
	return vibro_on


func set_sound(is_on: bool) -> bool:
	if sound_on != is_on:
		sound_on = is_on
		sound_changed.emit()
	return sound_on
	

func mute() -> void:
	is_sound_muted = true

func unmute() -> void:
	is_sound_muted = false


func set_language(lang: String) -> void:
	if not lang in ALL_LANGS.values():
		lang = 'en'
	if language != lang:
		language = lang
		TranslationServer.set_locale(language)
		if language != '':
			language_changed.emit()
