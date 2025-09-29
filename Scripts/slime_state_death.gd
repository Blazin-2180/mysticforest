class_name SlimeStateDeath extends SlimeState

@export var animation_name : String = "death"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _direction : Vector2

func init() -> void :
	slime.enemy_death.connect (_on_slime_death)
	pass

func enter() -> void : 
	slime.invulnerable = true
	_direction = slime.global_position.direction_to( slime.player.global_position )
	slime.set_direction ( _direction )
	slime.velocity = _direction * -knockback_speed
	slime.update_animation ( animation_name )
	slime.animation_player.animation_finished.connect( _on_animation_finished )
	pass

func process ( _delta : float ) -> SlimeState :
	slime.velocity -= slime.velocity * decelerate_speed * _delta
	return null
	
func physics( _delta : float ) -> SlimeState :
	return null
	
func _on_slime_death () -> void :
	slime_state_machine.change_state( self )

func _on_animation_finished ( _a : String ) -> void :
	slime.queue_free()

func _exit() -> void:
	pass
