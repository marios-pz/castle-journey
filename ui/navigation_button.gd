extends TextureButton

@export var level_to_navigate: String

func _ready() -> void:
	# Ensure the button can receive input
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed() -> void:
	print("Navigation button pressed! Going to level: ", level_to_navigate)
	var path = "res://scenes/levels/level_{level}/level_{level}.tscn".format({"level": level_to_navigate})
	print("Changing to scene: ", path)
	get_tree().change_scene_to_file(path)
