extends Button

func _on_pressed() -> void:
	var settings_node = get_node("../")
	settings_node.visible = false
	var menu_node = get_node("../../Control")
	menu_node.visible = true
