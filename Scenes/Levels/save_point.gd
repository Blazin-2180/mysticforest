class_name SavePoint extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_saved: Label = $GameSaved
@onready var timer: Timer = $GameSaved/Timer
@onready var interact_area: Area2D = $Area2D

var can_interact = false

func _ready() -> void:
	game_saved.visible = false
	interact_area.area_entered.connect( _on_area_enter )
	interact_area.area_exited.connect( _on_area_exit )

func _on_area_enter( _a : Area2D ) -> void :
	GlobalPlayerManager.interact_pressed.connect( interact )
	pass

func _on_area_exit( _a : Area2D ) -> void :
	GlobalPlayerManager.interact_pressed.disconnect( interact )
	pass
	
func _process(_delta: float) -> void:
	if can_interact &&  Input.is_action_pressed( "interact" ) :
		interact() 

func interact () -> void :
	GlobalSaveManager.save_game()
	animation_player.play ("saved")
	game_saved.visible = true 
	timer.start()
	print ("interacted with")

func _on_timer_timeout () -> void :
	game_saved.visible = false
