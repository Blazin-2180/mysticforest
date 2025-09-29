class_name State_Attack extends State

# Variables
var attacking : bool = false
@export_range(1, 20, 0.5) var decelerate_speed : float = 5.0

# References
@onready var player_sprite: Sprite2D = $"../../Player_Sprite"
@onready var attack_animation: AnimationPlayer = $"../../Player_Sprite/AnimationPlayer"

@onready var walk: State_Walk = $"../Walk"
@onready var idle : State_Idle = $"../Idle"

@onready var attack_hurt_box: HurtBox = %AttackHurtBox

# What happens when the player enters this state
func enter() -> void:
	player.update_animation ( "attack" )
	attack_animation.play( "attack_" + player.animation_direction () )
	attack_animation.animation_finished.connect ( end_attack )
	attacking = true
	attack_hurt_box.monitoring = true
	pass

# What happens when the player exits this state
func exit() -> void:
	attack_animation.animation_finished.disconnect ( end_attack )
	attacking = false
	# delays the attack animation
	await get_tree().create_timer(0.075).timeout
	# resets the hurtbox
	attack_hurt_box.monitoring = false
	pass

# What happens during the process update in this state 
func process ( _delta : float ) -> State :
	player.velocity -= player.velocity * decelerate_speed * _delta
	if attacking == false : 
		if player.direction == Vector2.ZERO :
			return idle
		else : 
			return walk
	return null

# What happens during the physics process update in this State
func physics ( _delta : float ) -> State :
	return null

# What happens with input events in this state
func handle_input ( _event : InputEvent ) -> State :
	return null

# Setting Attack state back to false once Attacking has ended
func end_attack ( _new_animation_name : String ) -> void :
	attacking = false
