class_name State_Death extends State

@onready var idle : State_Idle = $"../Idle"

var next_state : State = null

func init () -> void :
	pass
	
# What happens when the player enters this state ?
func enter() -> void:
	player.animation_player.play("death_down")
	#PlayerHud.show_death_screen()
	await player.animation_player.animation_finished
	respawn()
	pass

# What happens when the player exits this state ?
func exit() -> void:
	pass
	
# What happens during the process update in this state ?
func process (_delta : float) -> State :
	player.velocity = Vector2.ZERO
	return null

# What happens during the physics process update in this State ?
func physics( _delta : float ) -> State :
	return null
	
func respawn () -> void : 
	GlobalSaveManager.load_game()
	GlobalPlayerManager.health_points = GlobalPlayerManager.max_health_points
	if GlobalPlayerManager.health_points > 0 :
		next_state = idle
	pass
	
# What happens with input events in this state ?
func handle_input ( _event : InputEvent ) -> State :
	return null
