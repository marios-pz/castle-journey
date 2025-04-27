extends TextureButton



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/level_2/level_2.tscn")
