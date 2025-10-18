class_name BonbonStateMachine extends Node

# Variables
var states : Array [ BonbonState ]
var prev_state : BonbonState
var current_state : BonbonState

func _ready() -> void :
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process ( delta: float ) -> void :
	change_state(current_state.process( delta ) )
	pass

func _physics_process ( delta : float ) -> void :
	change_state( current_state.physics ( delta ) )
	pass

func inititalise ( _bonbon : Bonbon ) -> void :
	states = []
	for c in get_children():
		if c is BonbonState :
			states.append( c )
	for s in states : 
		s.bonbon = _bonbon
		s.bonbon_state_machine = self
		s.init()
		
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state ( new_state : BonbonState ) -> void :
	#Check the state we are switching to is not the same as the current one
	if new_state == null || new_state == current_state :
		return
	
	# If we are in a current state, set new state
	if current_state :
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
