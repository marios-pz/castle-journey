extends TextureButton

@export var quest: Quest

func _on_pressed() -> void:
	if quest.quest_status == quest.QuestStatus.available:
		quest.start_quest()
	
