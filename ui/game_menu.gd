extends Control

func _process(delta):
	if Input.is_action_just_pressed("open_menu"):
		visible = not visible
		var menu_node = get_node("./Control")
		var settings_node = get_node("./Settings")
		menu_node.visible = true
		settings_node.visible = false

func _ready() -> void:
	self.position = get_viewport_rect().size / 2 - Vector2(80, 80)

	
