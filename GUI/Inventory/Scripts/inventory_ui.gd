class_name InventoryUI extends Control

#region
const INVENTORY_SLOT = preload("res://GUI/Inventory/inventory_slot.tscn")
#endregion

#region // Export and Standard Variables
@export var data : InventoryData
var focus_index : int = 0
#endregion

#region /// On Ready Variables
@onready var head_slot: InventorySlotUI = %HeadSlot
@onready var shoulder_slot: InventorySlotUI = %ShoulderSlot
@onready var neck_slot: InventorySlotUI = %NeckSlot
@onready var back_slot: InventorySlotUI = %BackSlot
@onready var hand_slot: InventorySlotUI = %HandSlot
@onready var chest_slot: InventorySlotUI = %ChestSlot
@onready var ring_1_slot: InventorySlotUI = %Ring1Slot
@onready var leg_slot: InventorySlotUI = %LegSlot
@onready var ring_2_slot: InventorySlotUI = %Ring2Slot
@onready var main_hand_slot: InventorySlotUI = %MainHandSlot
@onready var feet_slot: InventorySlotUI = %FeetSlot
@onready var off_hand_slot: InventorySlotUI = %OffHandSlot
#endregion

func _ready() -> void:
	Inventory.shown.connect ( update_inventory )
	Inventory.hidden.connect ( clear_inventory )
	clear_inventory()
	data.changed.connect( on_inventory_changed )
	data.equipment_changed.connect( on_inventory_changed )
	pass

func clear_inventory () -> void :
	for c in get_children():
		c.set_slot_data( null )


func update_inventory( apply_focus : bool = true ) -> void :
	clear_inventory()

	var inventory_slots : Array[ SlotData ] = data.inventory_slots()

	#Update Inventory Slots
	for i in inventory_slots.size() :
		var slot : InventorySlotUI = get_child( i )
		slot.set_slot_data( inventory_slots [ i ] )

	# Update Equipment Slots
	var e_slots : Array[ SlotData ] = data.equipment_slots()
	head_slot.set_slot_data( e_slots[ 0 ])
	shoulder_slot.set_slot_data( e_slots[ 1 ])
	neck_slot.set_slot_data( e_slots[ 2 ])
	back_slot.set_slot_data( e_slots[ 3 ])
	hand_slot.set_slot_data( e_slots[ 4 ])
	chest_slot.set_slot_data( e_slots[ 5 ])
	ring_1_slot.set_slot_data( e_slots[ 6 ])
	leg_slot.set_slot_data( e_slots[ 7 ])
	ring_2_slot.set_slot_data( e_slots[ 8 ])
	main_hand_slot.set_slot_data( e_slots[ 9 ])
	feet_slot.set_slot_data( e_slots[ 10 ])
	off_hand_slot.set_slot_data( e_slots[ 11 ])
		
	if apply_focus :
		get_child( 0 ).grab_focus()

func item_focused() -> void :
	for i in get_child_count() :
		if get_child( i ).has_focus():
			focus_index = i
			return
	pass

func on_inventory_changed () -> void :
	update_inventory( false )
	pass
