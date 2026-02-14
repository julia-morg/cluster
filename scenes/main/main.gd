extends Node2D
class_name MainScene

var active_scene : Node2D = null


func change_to(scene: PackedScene):
	if active_scene:
		active_scene.queue_free()
		active_scene = null

	active_scene = scene.instantiate()
	add_child(active_scene)


func _ready() -> void:
	G.main = self
	G.screen_manager.show_loader()
