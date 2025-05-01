extends TextureButton


@export var level_to_navigate: String

func _on_pressed() -> void:
	var path = "res://scenes/levels/level_{level}/level_{level}.tscn".format({"level": level_to_navigate})
	get_tree().change_scene_to_file(path)
