class_name CreatureStateWander extends CreatureState 

@export var animation_name : String = 'walk'
@export var wander_speed : float = 20.0

@export_category('AI')
@export var state_animation_duration : float = 0.5
@export var state_cycles_min : int = 1
@export var state_cycles_max : int = 3
@export var next_state : CreatureState

var _timer : float = 0.0
var _direction : Vector2

#What happens when the state is initialised ?
func init() -> void :
	pass

# What happens when the creature enters this state
func enter() -> void :
	_timer = randi_range( state_cycles_min, state_cycles_max ) * state_animation_duration
	var rand = randi_range ( 0, 3 )
	_direction = creature.DIR_4[ rand ]
	creature.velocity = _direction * wander_speed
	creature.set_direction( _direction )
	creature.update_animation( animation_name )
	pass

# What happens when the creature exits this state
func exit() -> void :
	pass
	
# What happens during the process update in this state 
func process ( _delta : float ) -> CreatureState :
	_timer -= _delta
	if _timer < 0:
		return next_state
	return null

# What happens during the physics process update in this State
func physics( _delta : float ) -> CreatureState :
	return null
