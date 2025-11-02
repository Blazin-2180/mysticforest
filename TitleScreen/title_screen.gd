extends Node2D

const START_LEVEL : String = "res://Scenes/Levels/area_1.tscn"

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_pressed_audio : AudioStream

@onready var new_game_button: Button = $CanvasLayer/Control/NewGameButton
@onready var continue_button: Button = $CanvasLayer/Control/ContinueButton
@onready var exit_button: Button = $CanvasLayer/Control/ExitButton
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	get_tree().paused = true
	GlobalPlayerManager.player.visible = false
	PlayerHud.visible = false
	Inventory.process_mode = Node.PROCESS_MODE_DISABLED
	
	if GlobalSaveManager.get_save_file() == null :
		continue_button.disabled = true
	
	$CanvasLayer/SplashScreen.finished.connect( setup_title_screen)
	
	GlobalLevelManager.level_load_started.connect( exit_title_screen )
	pass

func setup_title_screen() -> void :
	AudioManager.play_music( music )
	new_game_button.pressed.connect( start_game )
	continue_button.pressed.connect ( continue_game )
	exit_button.pressed.connect ( exit_game )
	new_game_button.grab_focus()
	new_game_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	continue_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	exit_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )

	pass

func start_game() -> void : 
	play_audio( button_pressed_audio )
	GlobalLevelManager.load_new_level( START_LEVEL, "", Vector2.ZERO )
	pass

func continue_game() -> void :
	play_audio( button_pressed_audio )
	GlobalSaveManager.load_game()
	pass

func exit_title_screen() -> void :
	GlobalPlayerManager.player.visible = true
	PlayerHud.visible = true
	PlayerHud.visible = true
	Inventory.process_mode = Node.PROCESS_MODE_ALWAYS
	self.queue_free()
	pass

func exit_game() -> void :
	play_audio( button_pressed_audio )
	get_tree().quit()
	pass

func play_audio( _a : AudioStream) -> void :
	audio_player.stream = _a
	audio_player.play()
