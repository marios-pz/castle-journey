extends TextureButton

@onready var game_manager = get_node("/root/GameManager")
var npc_id: String = ""

func _ready() -> void:
	# Set the NPC ID based on the button's name
	npc_id = name.to_lower()
	connect("pressed", _on_pressed)

func _on_pressed() -> void:
	if game_manager and game_manager.text_bubble:
		game_manager.text_bubble.show_npc_text(npc_id) 
