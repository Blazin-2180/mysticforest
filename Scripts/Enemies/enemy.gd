class_name Enemy extends CharacterBody2D

signal direction_changed ( new_direction : Vector2 )
signal enemy_damaged(hurt_box : HurtBox)
signal enemy_death(hurt_box : HurtBox)

const DIR_4 = [ Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP ]

# Set enemy HP
@export var enemy_name : String = "Enemy"
@export var health_points : int = 3
@export var level : int = 1
@export var experience_points : int = 1
@export var aggressive : bool = false

var cardinal_direction : Vector2 = Vector2.DOWN
var direction : Vector2 = Vector2.ZERO
var player : Player
var invulnerable : bool = false

@onready var animation_player : AnimationPlayer = $EnemyAnimations
@onready var sprite : Sprite2D = $EnemySprite
@onready var hit_box: HitBox = $HitBox
@onready var enemy_state_machine: Node = $EnemyStateMachine

func _ready() -> void:
	enemy_state_machine.inititalise ( self )
	player = GlobalPlayerManager.player
	hit_box.damaged.connect( _take_damage )
	experience_points = level * 2
	pass

func _process ( _delta : float ) -> void:
	pass

func _physics_process( _delta : float ) -> void :
	move_and_slide()
	pass

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
	sprite.scale.x = -1 if cardinal_direction == Vector2.LEFT else 1
	return true
	
func update_animation ( state : String ) -> void :
	animation_player.play ( state + '_' + animation_direction() )
	pass

func animation_direction () -> String : 
	if cardinal_direction == Vector2.DOWN :
		return 'down'
	elif cardinal_direction == Vector2.UP :
		return 'up'
	else : 
		return 'side'

func _take_damage ( hurt_box : HurtBox ) -> void :
	if invulnerable == true:
		return
	health_points -= hurt_box.damage
	if health_points > 0 :
		enemy_damaged.emit( hurt_box )
	else:
		enemy_death.emit( hurt_box )
	print( health_points )
