class_name InventoryUI extends Control

#region
const INVENTORY_SLOT = preload("res://GUI/Inventory/inventory_slot.tscn")
#endregion

#region // Export and Standard Variables
@export var data : InventoryData
var focus_index : int = 0
#Dragable Inventory Items
var hovered_item : InventorySlotUI
#endregion

#region /// On Ready Variables
@onready var head_slot: InventorySlotUI = %HeadSlot
@onready var shoulder_slot: InventorySlotUI = %ShoulderSlot
@onready var neck_slot: InventorySlotUI = %NeckSlot
@onready var back_slot: InventorySlotUI = %BackSlot
@onready var hand_slot: InventorySlotUI = %HandSlot
@onready var chest_slot: InventorySlotUI = %ChestSlot
@onready var ring_1_slot: InventorySlotUI = %Ring1Slot
@onready var waist_slot: InventorySlotUI = %WaistSlot
@onready var leg_slot: InventorySlotUI = %LegSlot
@onready var ring_2_slot: InventorySlotUI = %Ring2Slot
@onready var main_hand_slot: InventorySlotUI = %MainHandSlot
@onready var feet_slot: InventorySlotUI = %FeetSlot
@onready var off_hand_slot: InventorySlotUI = %OffHandSlot
#endregion

#region /// Signals
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
		connect_item_signals( slot )

	# Update Equipment Slots
	var e_slots : Array[ SlotData ] = data.equipment_slots()
	head_slot.set_slot_data( e_slots[ 0 ])
	shoulder_slot.set_slot_data( e_slots[ 1 ])
	neck_slot.set_slot_data( e_slots[ 2 ])
	back_slot.set_slot_data( e_slots[ 3 ])
	hand_slot.set_slot_data( e_slots[ 4 ])
	chest_slot.set_slot_data( e_slots[ 5 ])
	ring_1_slot.set_slot_data( e_slots[ 6 ])
	waist_slot.set_slot_data( e_slots [ 7 ])
	leg_slot.set_slot_data( e_slots[ 8 ])
	ring_2_slot.set_slot_data( e_slots[ 9 ])
	main_hand_slot.set_slot_data( e_slots[ 10 ])
	feet_slot.set_slot_data( e_slots[ 11 ])
	off_hand_slot.set_slot_data( e_slots[ 12 ])

	#if apply_focus :
		#get_child( 0 ).grab_focus()


func item_focused() -> void :
	for i in get_child_count() :
		if get_child( i ).has_focus():
			focus_index = i
			return
	pass


func on_inventory_changed () -> void :
	update_inventory( false )
	pass


##Dragable Inventory Items

func connect_item_signals( item : InventorySlotUI ) -> void :
	if !item.button_up.is_connected( _on_item_drop ) :
		item.button_up.connect( _on_item_drop.bind( item ) )
	
	if !item.mouse_entered.is_connected( _on_item_mouse_entered) :
		item.mouse_entered.connect(_on_item_mouse_entered.bind( item ))
	
	if !item.mouse_exited.is_connected( _on_item_mouse_exited ) :
		item.mouse_exited.connect(_on_item_mouse_exited)
	pass


func _on_item_drop( item : InventorySlotUI ) -> void : 
	if item == null or item == hovered_item or hovered_item == null :
		return
	# Connect to data
	data.swap_items_by_index( item.get_index(), hovered_item.get_index() )
	update_inventory( false )
	pass


func _on_item_mouse_entered( item : InventorySlotUI ) -> void :
	hovered_item = item
	pass


func _on_item_mouse_exited() -> void :
	hovered_item = null
	pass
