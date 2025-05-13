class_name Quest extends QuestManager

#start the quest
func start_quest() -> void:
	#make sure this quest is available to start
	if quest_status == QuestStatus.available:
		#update quest status
		quest_status = QuestStatus.started
		#update ui
		QuestPanel.visible = true
		QuestTitle.text = quest_name
		QuestDescription.text = quest_description

#mark goal as reached
func reached_goal() -> void:
	if quest_status == QuestStatus.started:
		#update quest status
		quest_status = QuestStatus.reached_goal
		#update ui
		QuestDescription.text = reach_goal_text
