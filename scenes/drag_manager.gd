extends Node
class_name DragManager

const OFFSET = Vector2(0, -50)

var dragging = false
var drag_source : Node2D = null
var drag_obj : Node2D = null

var drop_targets : Array[Node2D] = []

var tween : Tween = null


func start_drag(source: Node2D, object: Node2D):
	drag_obj = object
	drag_obj.range_sprite.show()
	drag_source = source
	dragging = true


func stop_drag():
	dragging = false
	drop_targets.clear()


func add_drop_target(node: Node2D):
	if not drop_targets.has(node):
		drop_targets.append(node)


func remove_drop_target(node: Node2D):
	if drop_targets.has(node):
		drop_targets.erase(node)


func _process(_delta: float) -> void:
	if dragging:
		drag_obj.global_position = get_viewport().get_mouse_position()
		if not Input.is_action_pressed(&"tap"):
			drag_obj.range_sprite.hide()
			dragging = false
			if drop_targets:
				if drop_targets[-1].do_drop(drag_obj, drag_source):
					return

			drag_source.cancel_drag()
