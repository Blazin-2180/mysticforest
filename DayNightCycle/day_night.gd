extends StaticBody2D

var state : String = "day" # day or night
var change_state : bool = false
var length_of_day = 300 # seconds
var length_of_night = 150 # seconds

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var timer : Timer = $Timer
@onready var color : ColorRect = $ColorRect

func _ready() -> void:
	if state == "day" :
		color.color.a = 0
	elif state == "night" :
		color.color.a = 250

func _on_timer_timeout() -> void:
	if state == "day" :
		state = "night"
	elif state == "night" :
		state = "day"
	
	change_state = true
	
func _process( _delta : float) -> void:
	GlobalLevelManager.time_of_day = state
	if change_state == true :
		change_state = false
		if state == "day" :
			change_to_day()
			print("day")
		elif state == "night" :
			change_to_night()

func change_to_day() -> void :
	animation_player.play("night_to_day")
	timer.wait_time = length_of_day
	timer.start()
	pass

func change_to_night() -> void :
	animation_player.play("day_to_night")
	timer.wait_time = length_of_night
	timer.start()
	pass
