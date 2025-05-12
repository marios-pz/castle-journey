extends Control

var is_open = false
@export var inventory_slot : PackedScene
@onready var grid_container = $GridContainer

func _ready() -> void:
	close()
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
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
