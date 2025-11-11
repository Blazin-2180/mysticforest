extends Sprite2D

const FRAME_COUNT : int = 10

@onready var head_sprite: Sprite2D = $head_sprite
@onready var shoulder_sprite: Sprite2D = $shoulder_sprite
@onready var back_sprite: Sprite2D = $back_sprite
@onready var hand_sprite: Sprite2D = $hand_sprite
@onready var chest_sprite: Sprite2D = $chest_sprite
@onready var legs_sprite: Sprite2D = $legs_sprite
@onready var main_hand_above: Sprite2D = $main_hand_above
@onready var main_hand_below: Sprite2D = $main_hand_below
@onready var feet_sprite: Sprite2D = $feet_sprite
@onready var offhand_above: Sprite2D = $offhand_above
@onready var offhand_below: Sprite2D = $offhand_below


func _ready() -> void:
	GlobalPlayerManager.INVENTORY_DATA.equipment_changed.connect( _on_equipment_changed )
	pass


func _process( _delta : float ) -> void:
	head_sprite.frame = frame
	shoulder_sprite.frame = frame
	back_sprite.frame = frame
	hand_sprite.frame = frame
	chest_sprite.frame = frame
	legs_sprite.frame = frame
	#main_hand_above.frame = frame + FRAME_COUNT
	main_hand_below.frame = frame
	feet_sprite.frame = frame
	#offhand_above.frame = frame + FRAME_COUNT
	offhand_below.frame = frame
	pass

func _on_equipment_changed() -> void :
	var equipment : Array[ SlotData ] = GlobalPlayerManager.INVENTORY_DATA.equipment_slots()
	head_sprite.texture = equipment[ 0 ].item_data.sprite_texture
	shoulder_sprite.texture = equipment[ 1 ].item_data.sprite_texture
	back_sprite.texture = equipment[ 3 ].item_data.sprite_texture
	hand_sprite.texture = equipment[ 4 ].item_data.sprite_texture
	chest_sprite.texture = equipment[ 5 ].item_data.sprite_texture
	legs_sprite.texture = equipment[ 7 ].item_data.sprite_texture
	main_hand_above.texture = equipment[ 9 ].item_data.sprite_texture
	main_hand_below.texture = equipment[ 9 ].item_data.sprite_texture
	feet_sprite.texture = equipment[ 10 ].item_data.sprite_texture
	offhand_above.texture = equipment[ 11 ].item_data.sprite_texture
	offhand_below.texture = equipment[ 11 ].item_data.sprite_texture
	pass
