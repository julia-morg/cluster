@tool
class_name BButton
extends Control


func _on_button_down() -> void:
	var pos: Vector2 = self.global_position
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "global_position", pos +  Vector2(2, 2), 0.1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(self, "global_position", pos, 0.1).set_trans(Tween.TRANS_SINE)
