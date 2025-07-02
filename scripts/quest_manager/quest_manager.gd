class_name QuestManager extends Node2D

@onready var QuestPanel: Panel = get_parent().get_node("QuestPanel")
@onready var QuestTitle: RichTextLabel = QuestPanel.get_node("QuestTitle")
@onready var QuestDescription: RichTextLabel = QuestPanel.get_node("QuestDescription")

var quests = {}
var active_quest_id = null
var quest_status = null

enum QuestStatus{
	available,
	started,
	reached_goal,
	finished,
}

func _ready():
	_load_quests()

func _load_quests():
	var file = FileAccess.open("res://data/quests.json", FileAccess.READ)
	if file:
		var json = JSON.new()
		var error = json.parse(file.get_as_text())
		if error == OK:
			quests = json.get_data()
		else:
			print("QuestManager: Failed to parse quests.json")
	else:
		print("QuestManager: Could not open quests.json")

func try_start_quests_for_level(level_id: String):
	for quest_id in quests.keys():
		var quest = quests[quest_id]
		if quest.has("start_level") and quest["start_level"] == level_id:
			_start_quest(quest_id)

func try_complete_quests_for_level(level_id: String):
	if active_quest_id != null:
		var quest = quests[active_quest_id]
		if quest.has("end_level") and quest["end_level"] == level_id and quest_status == QuestStatus.started:
			_complete_quest(active_quest_id)

func _start_quest(quest_id: String):
	var quest = quests[quest_id]
	active_quest_id = quest_id
	quest_status = QuestStatus.started
	QuestPanel.visible = true
	QuestTitle.text = quest["name"]
	QuestDescription.text = quest["description"]

func _complete_quest(quest_id: String):
	var quest = quests[quest_id]
	quest_status = QuestStatus.finished
	QuestPanel.visible = false
	QuestDescription.text = quest["reach_goal_text"]
	if quest.has("reward_amount"):
		GameManager.gold += int(quest["reward_amount"]) 
