extends Control

func _process(delta):
	if Input.is_action_just_pressed("open_menu"):
		visible = not visible

func _ready() -> void:
	self.position = get_viewport_rect().size / 2 - Vector2(80, 80)

	
