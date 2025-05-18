extends Control


@onready var inv: Inv = preload("res://assets/player/inventory/items/inventory.tres")
@onready var slots: Array = $GridContainer.get_children()

var is_open = false

func update_slots():
	for i in range(min(inv.slots.size(), slots.size())):
		slots[i].update(inv.slots[i])


func _ready() -> void:
	inv.update.connect(update_slots)
	update_slots()
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
