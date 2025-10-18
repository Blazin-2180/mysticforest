class_name BonbonState extends Node
# Store a reference to the enemy this state belongs to
var bonbon : Bonbon
var bonbon_state_machine : BonbonStateMachine

#What happens when the state is initialised ?
func init() -> void :
	pass

func _ready() -> void :
	pass

# What happens when the enemy enters this state
func enter() -> void :
	pass

# What happens when the enemy exits this state
func exit() -> void :
	pass
	
# What happens during the process update in this state 
func _process( _delta : float ) -> void :
	pass

# What happens during the physics process update in this State
func physics( _delta : float ) -> BonbonState :
	return null
