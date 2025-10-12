class_name InventoryUI extends Control

#region
const INVENTORY_SLOT = preload("res://GUI/Inventory/inventory_slot.tscn")
#endregion

#region
@export var data : InventoryData
#endregion

func _ready() -> void:
	Inventory.shown.connect ( update_inventory )
	Inventory.hidden.connect ( clear_inventory )
	clear_inventory()
	pass

func clear_inventory () -> void :
	for c in get_children():
		c.queue_free()

func update_inventory() -> void :
	for s in data.slots :
		var new_slot = INVENTORY_SLOT.instantiate()
		add_child( new_slot )
		new_slot.slot_data = s
	get_child( 0 ).grab_focus()
