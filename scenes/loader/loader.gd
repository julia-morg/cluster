extends Node2D


func _ready() -> void:
	G.inited.connect(go_to_main_scene)

func go_to_main_scene(_is_success_init: bool = false):
	G.screen_manager.main_menu()
