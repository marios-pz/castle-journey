extends Control

var is_open = false

func _ready() -> void:
	close()
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("e"):
		if is_open:
			close()
		else:
			open()
			
func open():
	visible = true
	is_open = true

func close():
	visible = false
	is_open = false
