class_name QuestManager extends Node2D

@onready var QuestPanel: Panel = GameManager.get_node('QuestPanel')
@onready var QuestTitle: Panel = GameManager.get_node('QuestPanel').get_node("QuestTitle")
@onready var QuestDescription: Panel = GameManager.get_node('QuestPanel').get_node('QuestDescription')


@export_group("Guest Settings")

@export var quest_name: String
@export var quest_description: String
@export var reach_goal_text: String

enum QuestStatus{
	available,
	started,
	reached_goal,
	finished,
}

@export var quest_status: QuestStatus = QuestStatus.available
@export_group("Reward Settings")
@export var reward_amount: int 
