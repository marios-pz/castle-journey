extends Control


@onready var grid = $GridContainer

@export var inventory: Array[Item]

# Debugging
# @onready var item: Item = preload("res://assets/player/inventory/items/stick.tres")

var is_open = false

func _ready() -> void:
	# add_item_resource(item)
	close()

func update_slots():
	var grid = grid.get_children()
	var inv_size = inventory.size()
	for i in range(min(inv_size, grid.size())):
		grid[i].update(inventory[i])	

func add_item_resource(item: Item) -> void:
	inventory.append(item)
	update_slots()
	

func remove_item_resource(item: Item) -> void:
	for i in grid.get_child_count():
		var child = grid.get_child(i)
		if child.get_item() == item:
			child.unset_item()
			inventory.remove_at(i)
			break

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



#func insert(item: Item):
#	print("item set")
#	var item_slots = inventory.filter(func(slot): return slot.item == item)
#	if !item_slots.is_empty():
#		pass
#		# item_slots[0].amount = 1
#	else:
#		var empty_slot = inventory.filter(func(slot): return slot.item == null)
#		if !empty_slot.is_empty():
#			empty_slot[0].item = item
#			
#			# empty_slot[0].amount = 1
