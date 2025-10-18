class_name BnobonStateIdle extends BonbonState 

@export var animation_name : String = 'idle'

@export_category('AI')
@export var state_duration_min : float = 0.6
@export var state_duration_max : float = 1.8
@export var after_idle_state : BonbonState

var _timer : float = 0.0

#What happens when the state is initialised ?
func init() -> void :
	pass

func _ready() -> void :
	pass

# What happens when the enemy enters this state
func enter() -> void :
	bonbon.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	bonbon.update_animation( animation_name )
	pass

# What happens when the enemy exits this state
func exit() -> void :
	pass
	
# What happens during the process update in this state 
func process( _delta : float ) -> BonbonState :
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

# What happens during the physics process update in this State
func physics( _delta : float ) -> BonbonState :
	return null
