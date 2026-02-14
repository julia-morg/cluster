extends BButton


func _ready() -> void:
	self.pressed.connect(G.screen_manager.open_settings)
	
