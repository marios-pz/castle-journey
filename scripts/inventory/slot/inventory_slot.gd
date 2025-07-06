extends Panel
class_name InventorySlot

@onready var item_visual: Sprite2D = $CenterContainer/Panel/item_to_display
@onready var highlight: Sprite2D = $Highlight
var current_item: Item = null
var is_highlighted: bool = false
var click_count: int = 0
var click_timer: float = 0.0
var click_timeout: float = 0.5  # Time window for double click

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
	if not item is Item:
		print("Error: set_item called with non-Item type: ", typeof(item))
		return
	current_item = item
	item_visual.visible = true
	item_visual.texture = item.texture
	
func unset_item() -> void:
	current_item = null
	item_visual.visible = false
	item_visual.texture = null

func update(item: Item):
	if item != null and not item is Item:
		print("Error: update called with non-Item type: ", typeof(item))
		return
	current_item = item
	if !item:
		item_visual.visible = false
	else:
		item_visual.visible = true
		item_visual.texture = item.texture

func get_item() -> Item:
	return current_item

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and current_item:
			handle_click()

func _process(delta: float) -> void:
	if click_timer > 0:
		click_timer -= delta
		if click_timer <= 0:
			# Timeout - treat as single click
			if click_count == 1:
				handle_single_click()
			click_count = 0

func handle_click() -> void:
	click_count += 1
	click_timer = click_timeout
	
	if click_count == 2:
		# Double click - buy the item
		handle_double_click()
		click_count = 0
		click_timer = 0

func handle_single_click() -> void:
	# Single click - show/hide highlight
	if not is_highlighted:
		show_highlight()
	else:
		hide_highlight()

func handle_double_click() -> void:
	# Double click - buy the item
	if current_item:
		# Emit signal to parent to handle buying
		buy_item_requested.emit(current_item)

func show_highlight() -> void:
	if highlight:
		highlight.visible = true
		is_highlighted = true

func hide_highlight() -> void:
	if highlight:
		highlight.visible = false
		is_highlighted = false

signal buy_item_requested(item: Item)
