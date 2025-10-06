class_name EnemyStateDeath extends EnemyState

@export var animation_name : String = "death"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0

@export_category("AI")

var _damage_position : Vector2
var _direction : Vector2

func init() -> void :
	enemy.enemy_death.connect ( _on_enemy_death )
	pass

func enter() -> void : 
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to( _damage_position )
	enemy.set_direction ( _direction )
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation ( animation_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	pass

func process ( _delta : float ) -> EnemyState :
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func physics( _delta : float ) -> EnemyState :
	return null
	
func _on_enemy_death ( hurt_box : HurtBox ) -> void :
	_damage_position = hurt_box.global_position
	enemy_state_machine.change_state( self )
	hurt_box.monitoring = false # This is working but is also bringing up an error E 0:00:05:140   enemy_state_death.gd:35 @ _on_enemy_death(): Function blocked during in/out signal. Use set_deferred("monitoring", true/false).

func _on_animation_finished ( _a : String ) -> void :
	enemy.queue_free()
	print("Cob gains ", enemy.experience_points, " experience points")
	
func _exit() -> void:
	pass
