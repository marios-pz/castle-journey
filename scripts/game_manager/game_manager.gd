extends Node

var gold = 50

func _process(delta: float) -> void:
	$UiPanel/RichTextLabel.text = "GOLD: " + str(gold)
