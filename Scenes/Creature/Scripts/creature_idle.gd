class_name CreatureStateIdle extends CreatureState 

@export var animation_name : String = 'idle'

@export_category('AI')
@export var state_duration_min : float = 0.6
@export var state_duration_max : float = 1.8
@export var after_idle_state : CreatureState

var _timer : float = 0.0

#What happens when the state is initialised ?
func init() -> void :
	pass

func _ready() -> void :
	pass

# What happens when the creature enters this state
func enter() -> void :
	creature.velocity = Vector2.ZERO
	_timer = randf_range ( state_duration_min, state_duration_max )
	creature.update_animation( animation_name )
	pass

# What happens when the creature exits this state
func exit() -> void :
	pass
	
# What happens during the process update in this state 
func process( _delta : float ) -> CreatureState :
	_timer -= _delta
	if _timer <= 0:
		return after_idle_state
	return null

# What happens during the physics process update in this State
func physics( _delta : float ) -> CreatureState :
	return null
