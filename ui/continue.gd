extends Button



func _on_pressed() -> void:
	var menu_node = get_node("../../")
	menu_node.visible = false
