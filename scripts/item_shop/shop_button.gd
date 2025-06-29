extends TextureButton

func _ready() -> void:
	# Ensure the button can receive input
	mouse_filter = Control.MOUSE_FILTER_STOP

func _on_pressed() -> void:
	print("Shop button pressed!")
	var item_shop = get_node("../ItemShop")
	if item_shop:
		print("Opening item shop...")
		item_shop.open()
	else:
		print("Item shop not found!") 
