class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

<<<<<<< Updated upstream:Scripts/player.gd
@onready var player_sprite: Sprite2D = $Player_Sprite
@onready var state_machine: Node2D = $StateMachine
@onready var animation_player: AnimationPlayer = $Player_Sprite/AnimationPlayer
=======
#signal xp_updated

@onready var animation_player : AnimationPlayer = $Player_Sprite/AnimationPlayer
@onready var effect_animation_player : AnimationPlayer = $EffectAnimationPlayer
@onready var hit_box : HitBox = $HitBox
@onready var player_sprite : Sprite2D = $Player_Sprite
@onready var state_machine : PlayerStateMachine = $StateMachine

@export var character_name : String = "Cob"
@export var level : int = 1
@export var experience_points : int = 0
@export var attack : int = 1
@export var defence : int = 1
@export var movement_speed : int = 400
>>>>>>> Stashed changes:Scripts/Player/player.gd

var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN

signal direction_changed ( new_direction : Vector2 )

func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.initialise ( self )
	pass

func _process( _delta : float ) -> void:
	direction = Vector2 (
		Input.get_axis ( "left", "right" ),
		Input.get_axis ( "up", "down" )
	).normalized()
	pass

func _physics_process( _delta : float ) -> void:
	move_and_slide()

<<<<<<< Updated upstream:Scripts/player.gd
=======
#Testing
#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("jump") :
		#GlobalPlayerManager.reduce_health_points(99)
		#player_damaged.emit(%AttackHurtBox)
	#pass

>>>>>>> Stashed changes:Scripts/Player/player.gd
func set_direction() -> bool :
	if direction == Vector2.ZERO:
		return false

	var direction_id : int = int( round ( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_direction = DIR_4 [ direction_id ]

	if new_direction == cardinal_direction :
		return false
	cardinal_direction = new_direction
	direction_changed.emit( new_direction)
	player_sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true

#Update Animation depending on direction
func update_animation ( state : String ) -> void :
	animation_player.play(state + '_' + animation_direction())
	pass

#Change Character animateion direction
func animation_direction () -> String :
	if cardinal_direction == Vector2.DOWN :
		return "down"
	elif cardinal_direction == Vector2.UP :
		return "up"
	else : 
		return "side"
