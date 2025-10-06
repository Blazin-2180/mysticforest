class_name SavePoint extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_saved: Label = $GameSaved
@onready var timer: Timer = $GameSaved/Timer

var can_interact = false

func _ready() -> void:
	game_saved.visible = false
	pass
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" :
		can_interact = true
	Input.is_action_pressed("interact")
	pass # Replace with function body.

func _on_body_exited(body : Node2D) -> void :
	if body.name == "Player" :
		can_interact = false

func _process(_delta: float) -> void:
	if can_interact &&  Input.is_action_pressed( "interact" ) :
		interact() 

func interact () -> void :
	GlobalSaveManager.save_game()
	animation_player.play ("saved")
	game_saved.visible = true 
	timer.start()

func _on_timer_timeout () -> void :
	game_saved.visible = false
