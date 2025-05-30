extends Button

func _on_pressed() -> void:
	var control_node = get_node("/root/Menu/Control")
	var settings_node = get_node("/root/Menu/Settings")
	
	control_node.visible = true
	settings_node.visible = false
