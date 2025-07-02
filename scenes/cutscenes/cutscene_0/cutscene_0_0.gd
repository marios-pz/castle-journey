extends Control

func _ready() -> void:
	_call_when_ready()

func _call_when_ready():
	var game_manager = null
	if has_node("/root/GameManager"):
		game_manager = get_node("/root/GameManager")
	if game_manager and game_manager.text_bubble:
		game_manager.text_bubble.show_texts("cutscene_0")
		game_manager.text_bubble.connect("text_completed", _on_text_completed)
	else:
		# Try again after a short delay
		var timer = Timer.new()
		add_child(timer)
		timer.wait_time = 0.1
		timer.one_shot = true
		timer.timeout.connect(_call_when_ready)
		timer.start()

func _on_text_completed() -> void:
	# When text is completed, go to level 1
	# Use a timer to ensure we're still in the scene tree
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 0.1
	timer.one_shot = true
	timer.timeout.connect(_change_to_level_1)
	timer.start()

func _change_to_level_1() -> void:
	# Try different approaches to change scene
	var tree = get_tree()
	if tree != null:
		tree.change_scene_to_file("res://scenes/levels/level_1/level_1.tscn")
	else:
		print("Error: Cannot get tree!") 