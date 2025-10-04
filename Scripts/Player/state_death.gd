class_name State_Death extends State

@export var exhaust_audio : AudioStream

@onready var audio: AudioStreamPlayer2D = $"../../AudioStreamPlayer2D"


func init () -> void :
	pass
	
# What happens when the player enters this state ?
func enter() -> void:
	player.animation_player.play("death_down")
	audio.stream = exhaust_audio
	audio.play()
	#Trigger You Have Died
	PlayerHud.show_death_screen()
	#AudioManager.play_music(null)
	
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

# What happens with input events in this state ?
func handle_input ( _event : InputEvent ) -> State :
	return null
