extends Sprite2D

const FRAME_COUNT : int = 10

#@onready var head_sprite: Sprite2D = $head_sprite
#@onready var shoulder_sprite: Sprite2D = $shoulder_sprite
#@onready var back_sprite: Sprite2D = $back_sprite
@onready var hands_sprite: Sprite2D = $hands_sprite
@onready var chest_sprite: Sprite2D = $chest_sprite
@onready var legs_sprite: Sprite2D = $legs_sprite
@onready var feet_sprite: Sprite2D = $feet_sprite
#@onready var mainhand_above_sprite: Sprite2D = $mainhand_above_sprite
#@onready var mainhand_below_sprite: Sprite2D = $mainhand_below_sprite
#@onready var offhand_above_sprite: Sprite2D = $offhand_above_sprite
#@onready var offhand_below_sprite: Sprite2D = $offhand_below_sprite


func _ready() -> void:
	GlobalPlayerManager.INVENTORY_DATA.equipment_changed.connect( _on_equipment_changed )
	pass


func _process( _delta : float ) -> void:
	#head_sprite.frame = frame
	#shoulder_sprite.frame = frame
	#back_sprite.frame = frame
	hands_sprite.frame = frame
	chest_sprite.frame = frame
	legs_sprite.frame = frame
	#main_hand_above.frame = frame + FRAME_COUNT
	#mainhand_below_sprite.frame = frame
	feet_sprite.frame = frame
	#offhand_above_sprite.frame = frame + FRAME_COUNT
	#offhand_below_sprite.frame = frame
	pass

func _on_equipment_changed() -> void :
	var equipment : Array[ SlotData ] = GlobalPlayerManager.INVENTORY_DATA.equipment_slots()
	#head_sprite.texture = equipment[ 0 ].item_data.sprite_texture
	#shoulder_sprite.texture = equipment[ 1 ].item_data.sprite_texture
	#back_sprite.texture = equipment[ 3 ].item_data.sprite_texture
	hands_sprite.texture = equipment[ 4 ].item_data.sprite_texture
	chest_sprite.texture = equipment[ 5 ].item_data.sprite_texture
	legs_sprite.texture = equipment[ 7 ].item_data.sprite_texture
	feet_sprite.texture = equipment[10].item_data.sprite_texture
	#main_hand_above.texture = equipment[ 9 ].item_data.sprite_texture
	#mainhand_below_sprite.texture = equipment[ 9 ].item_data.sprite_texture
	#offhand_above_sprite = equipment[ 11 ].item_data.sprite_texture
	#offhand_below_sprite.texture = equipment[ 11 ].item_data.sprite_texture
	pass
