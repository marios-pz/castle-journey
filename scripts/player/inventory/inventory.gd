extends Resource

class_name Inv

signal update

@export var slots: Array[InvItem]

func insert(item: InvItem):
	var item_slots = slots.filter(func(slot): return slot.item == item)
	if !item_slots.is_empty():
		pass
		# item_slots[0].amount = 1
	else:
		var empty_slot = slots.filter(func(slot): return slot.item == null)
		if !empty_slot.is_empty():
			empty_slot[0].item = item
			# empty_slot[0].amount = 1
	# Update Slot UI
	update.emit()
