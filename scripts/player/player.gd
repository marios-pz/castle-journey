extends Control

@onready var inventory = $Inventory

@onready var item: InvItem = preload("res://assets/player/inventory/items/stick.tres")

func _ready() -> void:
	print("player loaded")
