extends Sprite2D

const FRAME_COUNT : int = 10

@export var head_sprite : Sprite2D
@export var shoulder_sprite : Sprite2D
@export var back_sprite : Sprite2D
@export var hand_sprite : Sprite2D
@export var chest_sprite : Sprite2D
@export var legs_sprite : Sprite2D
@export var main_hand_above : Sprite2D
@export var main_hand_below : Sprite2D
@export var feet_sprite : Sprite2D
@export var offhand_above : Sprite2D
@export var offhand_below : Sprite2D


func _ready() -> void:
	GlobalPlayerManager.INVENTORY_DATA.equipement_changed.connect( _on_equipment_changed )
	pass


func _process( _delta : float ) -> void:
	head_sprite.frame = frame
	shoulder_sprite.frame = frame
	back_sprite.frame = frame
	hand_sprite.frame = frame
	chest_sprite.frame = frame
	legs_sprite.frame = frame
	main_hand_above.frame = frame + FRAME_COUNT
	main_hand_below.frame = frame
	feet_sprite.frame = frame
	offhand_above.frame = frame + FRAME_COUNT
	offhand_below.frame = frame
	pass

func _on_equipment_changed() -> void :
	var equipment : Array[ SlotData ] = GlobalPlayerManager.INVENTORY_DATA.equipment_slots()
	texture = equipment[ 0 ].item_data.sprite_texture
	pass
