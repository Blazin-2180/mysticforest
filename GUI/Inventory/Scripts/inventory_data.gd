class_name InventoryData extends Resource

@export var slots : Array [SlotData]

func add_item ( item : ItemData, quantity : int = 1) -> bool : 
	for s in slots :
		if s :
			if s.item_data == item :
				s.quantity += quantity
				return true

	for i in slots.size() :
		if slots[ i ] == null :
			var new = SlotData.new()
			new.item_data = item
			new.quantity = quantity
			slots [ i ] = new
			return true

	print("inventory full")
	return false
