extends TextureButton

func _on_pressed() -> void:
	var item_shop = get_node("../ItemShop")
	if item_shop:
		item_shop.visible = true 