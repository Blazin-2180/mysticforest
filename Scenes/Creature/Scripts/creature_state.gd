class_name CreatureState extends Node

# Store a reference to the creature this state belongs to
var creature : Creature
var creature_state_machine : CreatureStateMachine

#What happens when the state is initialised ?
func init() -> void :
	pass

func _ready() -> void :
	pass

# What happens when the creature enters this state
func enter() -> void :
	pass

# What happens when the creature exits this state
func exit() -> void :
	pass
	
# What happens during the process update in this state 
func _process( _delta : float ) -> void :
	pass

# What happens during the physics process update in this State
func physics( _delta : float ) -> CreatureState :
	return null
