@tool
extends Control
class_name Currency

@export var text: String :
	set = _set_text
@export var icon: CompressedTexture2D
@onready var texture: TextureRect = $VBoxContainer/Icon
@onready var label: Label = $VBoxContainer/Label

func _ready() -> void:
	if icon:
		texture.texture = icon
	if texture:
		label.text = text

func _set_text(value):
	if label:
		label.text = value
		text = value
	return value
	
