extends Node2D

var gold: int = 200
var current_level: String = ""
@onready var inventory = $Inventory
@onready var text_bubble = $TextBubble

func _process(delta: float) -> void:
	$UiPanel/RichTextLabel.text = "GOLD: " + str(gold)

func _ready() -> void:
	# Initialize inventory
	inventory.visible = false
	# Initialize text bubble
	text_bubble.visible = false

func add_item(item: Item) -> void:
	inventory.add_item_resource(item)

func show_level_text() -> void:
	if current_level != "":
		print("Showing text for level: ", current_level)  # Debug print
		text_bubble.show_texts(current_level)

func set_current_level(level: String) -> void:
	current_level = level
	print("Current level set to: ", level)  # Debug print
	show_level_text() 
