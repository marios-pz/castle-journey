extends TextureButton


func _on_pressed() -> void:
	print(get_tree().current_scene)
	var current_scene = get_tree().current_scene
	var scene_name = current_scene.name.to_lower()
	var level_number = int(scene_name[-1]) - 1
	if level_number <= 0:
		return

	var prev_scene = "res://scenes/levels/level_{level}/level_{level}.tscn".format({"level": level_number})
	get_tree().change_scene_to_file(prev_scene)
