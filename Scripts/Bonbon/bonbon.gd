class_name Bonbon extends CharacterBody2D

signal direction_changed ( new_direction : Vector2 )

@onready var animation_player: AnimationPlayer = $BonbonSprite/AnimationPlayer
@onready var bonbon_sprite: Sprite2D = $BonbonSprite
@onready var bonbon_state_machine: BonbonStateMachine = $BonbonStateMachine

const SPEED = 350.0
const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]
	
var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO

func _ready() -> void:
	bonbon_state_machine.inititalise ( self )

func animation_direction () -> String : 
	if cardinal_direction == Vector2.DOWN :
		return 'down'
	elif cardinal_direction == Vector2.UP :
		return 'up'
	else : 
		return 'side'

func set_direction ( _new_direction : Vector2 ) -> bool :
	direction = _new_direction
	if direction == Vector2.ZERO :
		return false
		
	var direction_id : int = int( round (
		( direction + cardinal_direction * 0.1 ).angle()
		/ TAU * DIR_4.size()
	))
	var new_direction = DIR_4[direction_id]
	
	if new_direction == cardinal_direction :
		return false

	cardinal_direction = new_direction
	direction_changed.emit ( new_direction )
	bonbon_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

func update_animation ( state : String ) -> void :
	animation_player.play ( state + '_' + animation_direction() )
	pass
	
func _process(_delta: float) -> void:
	move_and_slide()
