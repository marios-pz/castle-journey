extends Control


@onready var grid = $GridContainer

@export var inventory: Array[Item]

# Debugging
# @onready var item: Item = preload("res://assets/player/inventory/items/stick.tres")

var is_open = false

func _ready() -> void:
	# add_item_resource(item)
	close()
	# Set mouse filter to block input behind inventory
	mouse_filter = Control.MOUSE_FILTER_STOP

func update_slots():
	var grid_children = grid.get_children()
	var inv_size = inventory.size()
	for i in range(min(inv_size, grid_children.size())):
		grid_children[i].update(inventory[i])	

func add_item_resource(item: Item) -> void:
	if item:
		inventory.append(item)
		update_slots()
	

func remove_item_resource(item: Item) -> void:
	if item:
		var index = inventory.find(item)
		if index != -1:
			inventory.remove_at(index)
			# Update the corresponding slot
			var grid_children = grid.get_children()
			if index < grid_children.size():
				grid_children[index].unset_item()
			update_slots()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("inventory"):
		if is_open:
			close()
		else:
			open()
			
func open():
	visible = true
	is_open = true
	# Ensure inventory is on top
	z_index = 1000
	# Block input behind inventory
	mouse_filter = Control.MOUSE_FILTER_STOP

func close():
	visible = false
	is_open = false
	# Allow input to pass through when closed
	mouse_filter = Control.MOUSE_FILTER_IGNORE



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
