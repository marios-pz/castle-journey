extends Panel
class_name InventorySlot

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_to_display
var current_item: Item = null

func _get_drag_data(at_position: Vector2) -> Variant:
	if not item_visual or not current_item:
		return
		
	var preview_texture = TextureRect.new()
	preview_texture.texture = $CenterContainer/Panel/item_to_display.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(49,49)
	
	var preview = Control.new()
	preview.add_child(preview_texture)
	set_drag_preview(preview)
	return self
	
func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is InventorySlot
	
func _drop_data(at_position: Vector2, data: Variant) -> void:
	if data is InventorySlot and data.current_item:
		set_item(data.current_item)
		
func set_item(item: Item) -> void:
	current_item = item
	item_visual.visible = true
	item_visual.texture = item.texture
	
func unset_item() -> void:
	current_item = null
	item_visual.visible = false
	item_visual.texture = null

func update(item: Item):
	current_item = item
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture

func get_item() -> Item:
	return current_item
