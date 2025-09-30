class_name EnemyStateMachine extends Node

# Variables
var states : Array [ EnemyState ]
var prev_state : EnemyState
var current_state : EnemyState

func _ready() -> void :
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process ( delta: float ) -> void :
	change_state(current_state.process( delta ) )
	pass

func _physics_process ( delta : float ) -> void :
	change_state( current_state.physics ( delta ) )
	pass

func inititalise ( _enemy : Enemy ) -> void :
	states = []
	for c in get_children():
		if c is EnemyState :
			states.append( c )
	for s in states : 
		s.enemy = _enemy
		s.enemy_state_machine = self
		s.init()
		
	if states.size() > 0:
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state ( new_state : EnemyState ) -> void :
	#Check the state we are switching to is not the same as the current one
	if new_state == null || new_state == current_state :
		return
	
	# If we are in a current state, set new state
	if current_state :
		current_state.exit()
	
	prev_state = current_state
	current_state = new_state
	current_state.enter()
