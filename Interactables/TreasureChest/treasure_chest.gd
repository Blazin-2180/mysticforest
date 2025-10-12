@tool
class_name TreasureChest extends Node2D

#region /// Export Variables
@export var item_data : ItemData : set = _set_item_data
@export var quantity : int = 1 : set = _set_quantity
#endregion

#region /// On Ready Variables
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var interact_area: Area2D = $Area2D
@onready var item_sprite: Sprite2D = $item_sprite
@onready var presistent_data_is_open: PersistentDataHandler = $PresistentDataIsOpen
#endregion

#region /// Standard Variables
var is_open : bool = false
#endregion

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint() :
		return
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )
	presistent_data_is_open.data_loaded.connect(set_chest_state)
	set_chest_state()
	pass

func set_chest_state() -> void:
	is_open = presistent_data_is_open.value
	if is_open :
		animation_player.play("opened")
	else :
		animation_player.play("closed")
	pass

func player_interact() -> void :
	if is_open == true :
		return
	is_open = true 
	presistent_data_is_open.set_value()
	animation_player.play("open_chest")
	if item_data && quantity > 0 :
		GlobalPlayerManager.INVENTORY_DATA.add_item( item_data, quantity )
	else :
		printerr("No Items In Chest")
		push_error("No Items In Chest! Chest name : ", name )
	pass 

func _on_area_enter( _a : Area2D ) -> void :
	GlobalPlayerManager.interact_pressed.connect( player_interact )
	pass

func _on_area_exit( _a : Area2D ) -> void :
	GlobalPlayerManager.interact_pressed.disconnect( player_interact )
	pass

func _set_item_data( value : ItemData ) -> void :
	item_data = value
	_update_texture()
	pass

func _set_quantity( value : int) -> void : 
	quantity = value
	pass

func _update_texture() -> void : 
	if item_data && item_sprite:
		item_sprite.texture = item_data.texture
