extends TextureButton

@export var level_to_navigate: String

func _ready() -> void:
	# Ensure the button can receive input
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed() -> void:
	print("Navigation button pressed! Going to level: ", level_to_navigate)
	if level_to_navigate == "credits":
		get_tree().change_scene_to_file("res://scenes/cutscenes/credits.tscn")
		return
	elif level_to_navigate == "item_shop":
		get_tree().change_scene_to_file("res://scenes/levels/level_item_shop/level_item_shop.tscn")
		return
	var path = "res://scenes/levels/level_{level}/level_{level}.tscn".format({"level": level_to_navigate})
	print("Changing to scene: ", path)
	get_tree().change_scene_to_file(path)
