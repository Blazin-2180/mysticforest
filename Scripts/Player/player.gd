class_name Player extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animation_player: AnimationPlayer = $Player_Sprite/AnimationPlayer
@onready var effect_animation_player: AnimationPlayer = $EffectAnimationPlayer
@onready var hit_box: HitBox = $Interactions/HitBox
@onready var player_sprite: Sprite2D = $Player_Sprite
@onready var state_machine: PlayerStateMachine = $StateMachine
@onready var health_bar: ProgressBar = $HealthBar
@onready var hp_label: Label = $HealthBar/HealthPoints


var direction : Vector2 = Vector2.ZERO
var cardinal_direction : Vector2 = Vector2.DOWN
var invulnerable = false
var health_points : int = 6
var max_health_points : int = 6

signal direction_changed ( new_direction : Vector2 )
signal player_damaged ( hurt_box : HurtBox )

func _ready() -> void:
	GlobalPlayerManager.player = self
	state_machine.initialise ( self )
	hit_box.damaged.connect ( take_damage )
	update_health_points(99)
	health_bar.value = max_health_points

	pass

func _process( _delta : float ) -> void:
	direction = Vector2 (
		Input.get_axis ( "left", "right" ),
		Input.get_axis ( "up", "down" )
	).normalized()
	pass

func _physics_process( _delta : float ) -> void:
	move_and_slide()

func set_direction() -> bool :
	if direction == Vector2.ZERO:
		return false

	var direction_id : int = int( round ( ( direction + cardinal_direction * 0.1 ).angle() / TAU * DIR_4.size() ) )
	var new_direction = DIR_4 [ direction_id ]

	if new_direction == cardinal_direction :
		return false
	cardinal_direction = new_direction
	direction_changed.emit ( new_direction )
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

func take_damage ( hurt_box : HurtBox ) -> void :
	if invulnerable == true :
		return
	update_health_points( -hurt_box.damage )
	
	if health_points > 0 :
		player_damaged.emit ( hurt_box )
		health_bar.value = health_points
		hp_label.text = str(health_points, "/", max_health_points)
	else : 
		player_damaged.emit ( hurt_box )
		update_health_points ( 99 )
		health_bar.value = health_points
		hp_label.text = str(health_points, "/", max_health_points)
	pass

func update_health_points ( delta : int) -> void :
	health_points = clampi ( health_points + delta, 0, max_health_points )
	print(health_points)
	pass

func make_invulnerable ( _duration : float = 1.0 ) -> void : 
	invulnerable = true
	hit_box.monitoring = false
	await get_tree().create_timer( _duration ).timeout
	invulnerable = false
	hit_box.monitoring = true
	pass
