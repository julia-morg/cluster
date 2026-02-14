extends Node
class_name SoundManager

const MUSIC_MAIN: String = "res://resources/sounds/music.ogg"
const SOUND_TUN: String  = "res://resources/sounds/sound.ogg"
var sound_player: AudioStreamPlayer
var _sound_was_playing_before_mute: bool = false


func _ready() -> void:
	G.settings.sound_changed.connect(_update_sound_volume)

func play_sound(sound_path: String, is_loop: bool = false) -> void:
	if not sound_player:
		sound_player = AudioStreamPlayer.new()
		add_child(sound_player)
	
	var resource = load(sound_path)
	if resource:
		resource.loop = is_loop
		sound_player.stream = resource
		sound_player.autoplay = true

	sound_player.volume_db = linear_to_db(50)
	if G.settings.is_sound_muted or not G.settings.sound_on:
		return
	sound_player.play()

func _update_sound_volume()->void:
	if G.settings.is_sound_muted or not G.settings.sound_on:
		mute()
	else:
		unmute()

func mute_sound() -> void:
	if sound_player and sound_player.playing:
		_sound_was_playing_before_mute = true
		sound_player.stop()


func unmute_sound() -> void:
	if _sound_was_playing_before_mute and sound_player:
		sound_player.play()
		_sound_was_playing_before_mute = false


func mute() -> void:
	mute_sound()


func unmute() -> void:
	unmute_sound()
