extends TextureButton


func _pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu/main_menu.tscn") 
