extends Control

@onready var grid = $GridContainer
@onready var helmet_slot = $EquipmentSlots/HelmetSlot
@onready var armor_slot = $EquipmentSlots/ArmorSlot
@onready var hands_slot = $EquipmentSlots/HandsSlot
@onready var leggings_slot = $EquipmentSlots/LeggingsSlot
@onready var weapon_slot = $EquipmentSlots/WeaponSlot

@export var inventory: Array[Item]

var equipped = {
	"helmet": null,
	"armor": null,
	"hands": null,
	"leggings": null,
	"weapon": null
}

# Flag to prevent infinite recursion
var is_unequipping = false

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
	# Update equipment slots - ensure we pass Item objects, not textures
	helmet_slot.update(equipped["helmet"] if equipped["helmet"] else null)
	armor_slot.update(equipped["armor"] if equipped["armor"] else null)
	hands_slot.update(equipped["hands"] if equipped["hands"] else null)
	leggings_slot.update(equipped["leggings"] if equipped["leggings"] else null)
	weapon_slot.update(equipped["weapon"] if equipped["weapon"] else null)

func add_item_resource(item: Item) -> void:
	if item:
		print("Adding item to inventory: ", item.name, " (type: ", typeof(item), ")")
		# Check if item should be auto-equipped (but not when unequipping)
		if not is_unequipping and item.item_type != null and item.item_type != "":
			print("Auto-equipping item: ", item.name, " to slot: ", item.item_type)
			equip_item(item)
		else:
			# Add to regular inventory if no item_type or when unequipping
			print("Adding item to regular inventory: ", item.name)
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

func equip_item(item: Item) -> void:
	if not item or item.item_type == null or item.item_type == "":
		return
	var slot_name = item.item_type
	if equipped.has(slot_name):
		# Unequip current item if any
		if equipped[slot_name]:
			is_unequipping = true
			add_item_resource(equipped[slot_name])
			is_unequipping = false
		equipped[slot_name] = item
		remove_item_resource(item)
		update_slots()

func unequip_item(slot_name: String) -> void:
	if equipped.has(slot_name) and equipped[slot_name]:
		is_unequipping = true
		add_item_resource(equipped[slot_name])
		is_unequipping = false
		equipped[slot_name] = null
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
