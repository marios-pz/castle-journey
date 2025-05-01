extends Node


func _on_ready() -> void:
	if get_node_or_null("Player") == null:
		add_child(Player)
