extends Node2D
class_name MessageScreen

signal back_pressed

@onready var title_label:Label = $UIRoot/Panel/VBoxContainer/TitleLabel
@onready var subtitle_label:Label = $UIRoot/Panel/VBoxContainer/SubtitleLabel
@onready var exit_btn:BButton = $UIRoot/Panel/Exit

var title_text: String = ''
var subtitle_text: String = ''

func _ready() -> void:
	exit_btn.button_up.connect(_on_exit_pressed)
	

func set_title(text: String) -> void:
	title_text = text
	title_label.text = title_text

func set_subtitle(text: String) -> void:
	subtitle_text = text
	subtitle_label.text = text

func _on_exit_pressed() -> void:
	back_pressed.emit()
