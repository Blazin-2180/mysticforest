@tool
class_name LevelTransition extends Area2D

enum SIDE { LEFT, RIGHT, TOP, BOTTOM }

# Will only open Scene files
@export_file( "*.tscn" ) var level

@export var target_transition_area : String = "LevelTransition"
@export_category( "Collision Area Settings" )

@export_range( 1, 12, 1, "or_greater" ) var size : int = 2 :
	set ( _v ) :
		size = _v
		_update_area()
		
@export var side : SIDE = SIDE.LEFT :
	set ( _v ) :
		side = _v
		_update_area()
		
@export var snap_to_grid : bool = false :
	set( _v ):
		_snap_to_grid()

@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	_update_area()
	if Engine.is_editor_hint():
		return

	monitoring = false
	_place_player()

	await GlobalLevelManager.level_loaded
	monitoring = true

	body_entered.connect( _player_entered )
	
	pass

func _player_entered( _p : Node2D ) -> void :
	GlobalLevelManager.load_new_level( level, target_transition_area, get_offset() )
	pass

func _place_player() -> void :
	if name != GlobalLevelManager.target_transition:
		return
	GlobalPlayerManager.set_player_position( global_position + GlobalLevelManager.position_offset )

func get_offset() -> Vector2 :
	var offset : Vector2 = Vector2.ZERO
	var player_position = GlobalPlayerManager.player.global_position
	
	if side == SIDE.LEFT || side == SIDE.RIGHT :
		offset.y = player_position.y - global_position.y
		offset.x = 8
		if side == SIDE.LEFT :
			offset.x *= -1
		else : 
			offset.x = player_position.x - global_position.x
			offset.y = 8
			if side == SIDE.TOP :
				offset.y *= -1				
	return offset

#Update collision shape
func _update_area () -> void :
	var new_rectangle : Vector2 = Vector2(16,16)
	var new_position : Vector2 = Vector2.ZERO
	
	if side == SIDE.TOP : 
		new_rectangle.x *= size
		new_position.y -= 8
	elif side == SIDE.BOTTOM :
		new_rectangle.x *= size
		new_position.y += 8
	elif side == SIDE.LEFT :
		new_rectangle.y *= size
		new_position.x -= 8
	elif side == SIDE.RIGHT :
		new_rectangle.y *= size
		new_position.x += 8
		
	if collision_shape == null :
		collision_shape = get_node( "CollisionShape2D" )
	
	collision_shape.shape.size = new_rectangle
	collision_shape.position = new_position
	pass

func _snap_to_grid () -> void :
	position.x = round( position.x / 8 ) * 8
	position.y = round( position.x / 8 ) * 8
