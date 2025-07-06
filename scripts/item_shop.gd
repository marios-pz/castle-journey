extends Control

var inventory_grid: GridContainer
var buy_button: Button
var leave_button: Button
var item_shop_ui: Control
var coin_label: Label
var notification_label: Label

var inventory_slots = []
var available_items = []

# Get reference to GameManager
var game_manager: Node

# Preload the item resources
var stick_item = preload("res://assets/items/stick.tres")
var sword_item = preload("res://assets/items/sword.tres")
var armor_item = preload("res://assets/items/armor.tres")

func _ready():
	# Wait for the next frame to ensure all nodes are ready
	await get_tree().process_frame
	
	# Get GameManager reference
	game_manager = get_node("/root/GameManager")
	
	# Get references to UI elements
	item_shop_ui = get_node("ItemShopUI")
	inventory_grid = get_node("ItemShopUI/BackgroundPanel/InventoryGrid")
	buy_button = get_node("ItemShopUI/BackgroundPanel/BuyButton")
	leave_button = get_node("ItemShopUI/BackgroundPanel/LeaveButton")
	coin_label = get_node("ItemShopUI/BackgroundPanel/CoinLabel")
	notification_label = get_node("ItemShopUI/BackgroundPanel/NotificationLabel")
	
	# Check if all nodes were found
	if not item_shop_ui:
		print("Error: ItemShopUI not found!")
		return
	if not inventory_grid:
		print("Error: InventoryGrid not found!")
		return
	if not buy_button:
		print("Error: BuyButton not found!")
		return
	if not leave_button:
		print("Error: LeaveButton not found!")
		return
	if not coin_label:
		print("Error: CoinLabel not found!")
		return
	if not notification_label:
		print("Error: NotificationLabel not found!")
		return
	
	# Hide UI initially
	item_shop_ui.visible = false
	
	# Connect button signals
	buy_button.pressed.connect(_on_buy_pressed)
	leave_button.pressed.connect(_on_leave_pressed)
	
	# Set up inventory slots
	setup_inventory_slots()
	
	# Update coin display
	update_coin_display()
	
	# Show UI when entering the shop
	item_shop_ui.visible = true

func setup_inventory_slots():
	# Check if inventory grid exists
	if not inventory_grid:
		print("Warning: Inventory grid not found!")
		return
		
	# Create inventory slots
	for i in range(12):  # 12 slots for the shop
		var slot = preload("res://scripts/inventory/slot/inventory_slot.tscn").instantiate()
		inventory_grid.add_child(slot)
		inventory_slots.append(slot)
	
	# Add items to the first few slots
	if stick_item:
		inventory_slots[0].set_item(stick_item)
		inventory_slots[0].buy_item_requested.connect(_on_item_buy_requested)
	if sword_item:
		inventory_slots[1].set_item(sword_item)
		inventory_slots[1].buy_item_requested.connect(_on_item_buy_requested)
	if armor_item:
		inventory_slots[2].set_item(armor_item)
		inventory_slots[2].buy_item_requested.connect(_on_item_buy_requested)

func update_coin_display():
	if coin_label and game_manager:
		coin_label.text = "GOLD: " + str(game_manager.gold)

func show_notification(message: String, is_error: bool = false):
	if notification_label:
		notification_label.text = message
		notification_label.visible = true
		
		# Set color based on message type
		if is_error:
			notification_label.modulate = Color.RED
		else:
			notification_label.modulate = Color.GREEN
		
		# Hide notification after 3 seconds
		var timer = get_tree().create_timer(3.0)
		timer.timeout.connect(func(): notification_label.visible = false)

func _on_buy_pressed():
	# For now, just print a message since we're not adding items yet
	print("Buy button pressed - items will be added later")

func _on_item_buy_requested(item: Item) -> void:
	if not item or not game_manager:
		return
		
	print("Attempting to buy: ", item.name, " for ", item.price, " gold")
	print("Player has: ", game_manager.gold, " gold")
	
	if game_manager.gold >= item.price:
		# Player has enough gold
		game_manager.gold -= item.price
		print("Successfully bought ", item.name, "! Remaining gold: ", game_manager.gold)
		
		# Show success notification
		show_notification("Successfully bought " + item.name + "!", false)
		
		# Update coin display
		update_coin_display()
		
		# Remove item from shop
		remove_item_from_shop(item)
	else:
		# Show error notification
		show_notification("Not enough gold! Need " + str(item.price) + " but have " + str(game_manager.gold), true)

func remove_item_from_shop(item: Item) -> void:
	# Find the slot with this item and remove it
	for slot in inventory_slots:
		if slot.get_item() == item:
			slot.unset_item()
			slot.hide_highlight()
			break

func _on_leave_pressed():
	# Navigate back to level_6
	get_tree().change_scene_to_file("res://scenes/levels/level_6/level_6.tscn") 
