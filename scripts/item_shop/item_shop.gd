extends Control

@onready var grid = $GridContainer
@onready var exit_button = $ExitButton

var selected_slot: int = -1
var shop_items: Array[Item] = []

func _ready() -> void:
	close()
	exit_button.pressed.connect(_on_exit_pressed)
	
	# Load shop items
	var sword = load("res://assets/player/inventory/items/sword.tres")
	if sword:
		shop_items.append(sword)
	
	# Create slots
	for i in range(shop_items.size()):
		var slot = TextureButton.new()
		slot.custom_minimum_size = Vector2(64, 64)
		slot.expand_mode = TextureButton.EXPAND_FILL
		slot.stretch_mode = TextureButton.STRETCH_KEEP_ASPECT_CENTERED
		slot.texture_normal = shop_items[i].texture
		slot.pressed.connect(_on_slot_pressed.bind(i))
		grid.add_child(slot)

func update_slots():
	var grid_slots = grid.get_children()
	var shop_size = shop_items.size()
	for i in range(min(shop_size, grid_slots.size())):
		grid_slots[i].texture = shop_items[i].texture

func _on_slot_pressed(slot_index: int) -> void:
	if selected_slot == slot_index:
		# Second click - try to purchase
		var item = shop_items[slot_index]
		var game_manager = get_node("/root/GameManager")
		if game_manager.gold >= item.price:
			game_manager.gold -= item.price
			game_manager.add_item(item)
			# Remove item from shop
			shop_items.remove_at(slot_index)
			grid.get_child(slot_index).queue_free()
		selected_slot = -1
	else:
		# First click - select slot
		selected_slot = slot_index

func _on_exit_pressed() -> void:
	close()

func open() -> void:
	visible = true
	update_slots()

func close() -> void:
	visible = false
	if selected_slot != -1:
		selected_slot = -1 
