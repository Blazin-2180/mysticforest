class_name InventoryData extends Resource

signal equipment_changed

@export var slots : Array[ SlotData ]
var equipment_slot_count : int = 13

func _init() -> void:
	connect_slots()
	pass


func inventory_slots() -> Array [ SlotData ] :
	return slots.slice( 0, - equipment_slot_count )


func equipment_slots() -> Array [ SlotData ] :
	return slots.slice( - equipment_slot_count, slots.size() )
	

func add_item ( item : ItemData, quantity : int = 1) -> bool : 
	for s in slots :
		if s :
			if s.item_data == item :
				s.quantity += quantity
				return true


	for i in inventory_slots().size() :
		if slots[ i ] == null :
			var new = SlotData.new()
			new.item_data = item
			new.quantity = quantity
			slots [ i ] = new
			new.changed.connect( slot_changed )
			return true

	print("inventory full")
	return false


func connect_slots() -> void : 
	for s in slots:
		if s :
			s.changed.connect( slot_changed )


func slot_changed() -> void :
	for s in slots :
		if s :
			if s.quantity < 1:
				s.changed.disconnect( slot_changed )
				var index = slots.find( s )
				slots[ index ] = null
				emit_changed()
	pass


# Gather the inventory into an Array
func get_save_data() ->  Array :
	var item_save : Array = []
	for i in slots.size() :
		item_save.append( item_to_save( slots[i] ) )
	return item_save


# Convert each inventory item into a dictionary
func item_to_save( slot : SlotData ) -> Dictionary :
	var result = { item = "", quantity = 0 }
	if slot != null :
		result.quantity = slot.quantity
		if slot.item_data != null :
			result.item = slot.item_data.resource_path
	return result
	
	
func parse_save_data( save_data : Array ) -> void :
	var array_size = slots.size()
	slots.clear()
	slots.resize( array_size )
	for i in save_data.size() :
		slots[i] = item_from_save ( save_data[i] )
	connect_slots()


func item_from_save ( save_object : Dictionary) -> SlotData :
	if save_object.item == "":
		return null
	var new_slot : SlotData = SlotData.new()
	new_slot.item_data = load( save_object.item)
	new_slot.quantity = int( save_object.quantity )
	return new_slot


func use_item( item : ItemData, count : int = 1) -> bool :
	for s in slots :
		if s :
			if s.item_data == item && s.quantity >= count :
				s.quantity -= count
				return true
	return false


func swap_items_by_index( index1 : int, index2 : int ) -> void :
	var temp : SlotData = slots[ index1 ]
	slots[ index1 ] = slots[ index2 ]
	slots[ index2 ] = temp
	pass


func equip_item ( slot : SlotData ) -> void :
	if slot == null || !slot.item_data is EquipableItemData :
		return
	
	var item : EquipableItemData = slot.item_data
	var slot_index : int = slots.find( slot )
	var equipment_index : int = slots.size() - equipment_slot_count
	
	match item.type :
		EquipableItemData.Type.HEAD :
			equipment_index += 0
			pass
		EquipableItemData.Type.SHOULDERS :
			equipment_index += 1
			pass
		EquipableItemData.Type.NECK :
			equipment_index += 2
			pass
		EquipableItemData.Type.BACK :
			equipment_index += 3
			pass
		EquipableItemData.Type.HANDS :
			equipment_index += 4
			pass
		EquipableItemData.Type.CHEST :
			equipment_index += 5
			pass
		EquipableItemData.Type.RING1 :
			equipment_index += 6
			pass
		EquipableItemData.Type.WAIST:
			equipment_index = 7
			pass
		EquipableItemData.Type.LEGS :
			equipment_index += 8
			pass
		EquipableItemData.Type.RING2 :
			equipment_index += 9
			pass
		EquipableItemData.Type.MAINHAND :
			equipment_index += 10
			pass
		EquipableItemData.Type.FEET :
			equipment_index += 11
			pass
		EquipableItemData.Type.OFFHAND :
			equipment_index += 12
			pass

	var unequiped_slot : SlotData = slots[ equipment_index ]

	slots[ slot_index ] = unequiped_slot
	slots[ equipment_index ] = slot

	equipment_changed.emit()

	Inventory.focus_item_changed( unequiped_slot )

	pass

func get_attack_bonus() -> int :
	return get_equipment_bonus( EqiupableItemModifier.Type.ATTACK )


func get_attack_bonus_difference( item : EquipableItemData ) -> int :
	var before : int = get_attack_bonus()
	var after : int = get_equipment_bonus( EqiupableItemModifier.Type.ATTACK, item )
	return after - before
	
func get_defence_bonus() -> int :
	return get_equipment_bonus( EqiupableItemModifier.Type.DEFENCE )


func get_defence_bonus_difference( item : EquipableItemData ) -> int :
	var before : int = get_defence_bonus()
	var after : int = get_equipment_bonus( EqiupableItemModifier.Type.DEFENCE, item )
	return after - before

func get_health_bonus() -> int :
	return get_equipment_bonus( EqiupableItemModifier.Type.HEALTH )


func get_health_bonus_difference( item : EquipableItemData ) -> int :
	var before : int = get_health_bonus()
	var after : int = get_equipment_bonus( EqiupableItemModifier.Type.HEALTH, item )
	return after - before


func get_equipment_bonus( bonus_type : EqiupableItemModifier.Type, compare : EquipableItemData = null) -> int : 
	var bonus : int = 0
	for s in equipment_slots() :
		if s == null :
			continue
			
		var e : EquipableItemData = s.item_data
		if compare :
			if e.type == compare.type :
				e = compare
				
		for m in e.modifiers : 
			if m.type == bonus_type :
				bonus += m.value
	return bonus
