class_name SlimeStateStun extends SlimeState

@export var animation_name : String = "stun"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")
@export var next_state : SlimeState

var _direction : Vector2
var _animation_finished : bool = false

func init() -> void :
	slime.enemy_damaged.connect (_on_enemy_damaged)
	pass

func enter() -> void : 
	slime.invulnerable = true
	_animation_finished = false
	_direction = slime.global_position.direction_to( slime.player.global_position )
	slime.set_direction ( _direction )
	slime.velocity = _direction * -knockback_speed
	slime.update_animation (animation_name)
	
	slime.animation_player.animation_finished.connect( _on_animation_finished )
	pass

func process ( _delta : float ) -> SlimeState :
	if _animation_finished == true:
		return next_state
	slime.velocity -= slime.velocity * decelerate_speed * _delta
	return null
	
func physics(_delta : float) -> SlimeState :
	return null
	
func _on_enemy_damaged () -> void :
	slime_state_machine.change_state( self )

func _on_animation_finished ( _a : String ) -> void :
	_animation_finished = true

func _exit() -> void:
	slime.invulnerable = false
	slime.animation_player.animation_finished.disconnect( _on_animation_finished )
	pass
