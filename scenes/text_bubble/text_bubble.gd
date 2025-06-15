extends Control

var current_texts: Array = []
var current_index: int = 0

func _ready() -> void:
	visible = false

func show_npc_text(npc_id: String) -> void:
	var json = JSON.new()
	var file = FileAccess.open("res://data/npc_interactions.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		var error = json.parse(json_text)
		if error == OK:
			var data = json.get_data()
			if data.has(npc_id):
				current_texts = data[npc_id]
				current_index = 0
				visible = true
				_update_text()
			else:
				visible = false
		else:
			print("JSON Parse Error: ", json.get_error_message())
	else:
		print("Failed to open npc_interactions.json")

func _update_text() -> void:
	if current_index < current_texts.size():
		$Text.text = current_texts[current_index]
		$NextButton.visible = true
	else:
		visible = false
		$NextButton.visible = false

func _on_next_button_pressed() -> void:
	current_index += 1
	if current_index >= current_texts.size():
		visible = false
		$NextButton.visible = false
	_update_text() 
