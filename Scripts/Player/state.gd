class_name State extends Node

# Static Variables
# Stores a reference to the player that this state belongs to
static var player : Player
static var state_machine : PlayerStateMachine

func _ready() -> void:
	pass

# What happens when the state is initialised ?
func init () -> void :
	pass
	
# What happens when the player enters this state ?
func enter() -> void:
	pass

# What happens when the player exits this state ?
func exit() -> void:
	pass
	
# What happens during the process update in this state ?
func process (_delta : float) -> State :
	return null

# What happens during the physics process update in this State ?
func physics( _delta : float ) -> State :
	return null

# What happens with input events in this state ?
func handle_input ( _event : InputEvent ) -> State :
	return null
