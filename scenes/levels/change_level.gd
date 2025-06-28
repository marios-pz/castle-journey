extends Node

func _ready() -> void:
	var game_manager = get_node("/root/GameManager")
	if game_manager:
		var level_name = "level_" + name.to_lower().replace("level", "")
		print("Setting current level to: ", level_name)  # Debug print
		game_manager.set_current_level(level_name)
	else:
		print("GameManager not found!")  # Debug print
