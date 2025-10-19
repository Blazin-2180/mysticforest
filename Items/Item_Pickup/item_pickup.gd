@tool 
class_name ItemPickup extends CharacterBody2D

signal picked_up

#region /// On Ready Variables
@onready var area: Area2D = $Area2D
@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer2D = $AudioStreamPlayer2D
#endregion

#region /// Export Variable
@export var item_data : ItemData : set = _set_item_data
#endregion

func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint() :
		return
	area.body_entered.connect( _on_body_entered )
	
func _physics_process(delta : float) -> void :
	var collision_info = move_and_collide( velocity * delta)
	if collision_info :
		velocity = velocity.bounce( collision_info.get_normal())
	velocity -= velocity * delta * 4

func _on_body_entered( b ) -> void :
	if b is Player :
		if item_data : 
			if GlobalPlayerManager.INVENTORY_DATA.add_item( item_data ) == true :
				item_picked_up()
	pass

func item_picked_up() -> void :
	area.body_entered.disconnect(_on_body_entered)
	audio_stream_player.play()
	visible = false
	picked_up.emit()
	await audio_stream_player.finished
	queue_free()
	pass

func _update_texture() -> void : 
	if item_data && sprite : 
		sprite.texture = item_data.texture
	pass
	
func _set_item_data( value : ItemData ) -> void : 
	item_data = value
	_update_texture()
	pass
