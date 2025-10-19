@tool
class_name ItemDropper extends Node2D

const PICKUP = preload( "res://Items/Item_Pickup/item_pickup.tscn" )

@export var item_data : ItemData : set = _set_item_data

@onready var sprite : Sprite2D = $Sprite2D
@onready var audio : AudioStreamPlayer = $AudioStreamPlayer
@onready var has_dropped_data : PersistentDataHandler = $PresistentDataHandler

var has_dropped : bool = false

func _ready() -> void:
	if Engine.is_editor_hint() == true :
		_update_texture()
		return
	sprite.visible = false
	has_dropped_data.data_loaded.connect( _on_data_loaded )
	_on_data_loaded()

func _set_item_data( value : ItemData) -> void :
	item_data = value
	_update_texture()
	pass


func drop_item() -> void :
	if has_dropped == true :
		return
	has_dropped = true
	
	var drop = PICKUP.instantiate() as ItemPickup
	drop.item_data = item_data
	add_child( drop )
	drop.picked_up.connect( _on_drop_pickup )
	#audio.play()
	pass


func _on_drop_pickup() -> void :
	has_dropped_data.set_value()
	pass


func _on_data_loaded() -> void :
	has_dropped = has_dropped_data.value
	pass


func _update_texture() -> void :
	if Engine.is_editor_hint() == true :
		if item_data && sprite :
			sprite.texture = item_data.texture
	pass


func _on_treasure_chest_visibility_changed() -> void:
	pass # Replace with function body.
