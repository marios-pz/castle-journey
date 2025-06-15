extends Node2D

@onready var game_manager = get_node("/root/GameManager")
@onready var interact_button = $InteractButton

var npc_id: String = ""
var coins: int = 0
var inventory_items: Array[Item] = []

func _ready() -> void:
	# Set the NPC ID based on the node's name
	npc_id = name.to_lower()
	interact_button.connect("pressed", _on_interact_pressed)

func _on_interact_pressed() -> void:
	if game_manager and game_manager.text_bubble:
		print("Showing NPC text for: ", npc_id)  # Debug print
		game_manager.text_bubble.show_npc_text(npc_id)

# Function to add items to NPC's inventory
func add_item(item: Item) -> void:
	inventory_items.append(item)

# Function to remove items from NPC's inventory
func remove_item(item: Item) -> void:
	inventory_items.erase(item)

# Function to add coins to NPC
func add_coins(amount: int) -> void:
	coins += amount

# Function to remove coins from NPC
func remove_coins(amount: int) -> bool:
	if coins >= amount:
		coins -= amount
		return true
	return false

# Function to check if NPC has enough coins
func has_enough_coins(amount: int) -> bool:
	return coins >= amount 
