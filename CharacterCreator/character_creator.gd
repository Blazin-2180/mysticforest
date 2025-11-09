class_name CharacterCreator extends Node2D

@onready var name_box : TextEdit = $CanvasLayer/Control/ColorRect/Details/NameBox
@onready var audio_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var confirm_button: Button = $CanvasLayer/ConfirmButton

@export var music : AudioStream
@export var button_focus_audio : AudioStream
@export var button_pressed_audio : AudioStream

var player_name = ""


func _ready() -> void:
	GlobalPlayerManager.player.visible = false
	#GlobalPlayerManager.player.process_mode = Node.PROCESS_MODE_DISABLED
	PlayerHud.visible = false
	DayNight.visible = false
	Inventory.process_mode = Node.PROCESS_MODE_DISABLED
	setup_create_screen()
	pass


func setup_create_screen() -> void :
	AudioManager.play_music( music )
	#confirm_button.pressed.connect ( _on_confirm_button_pressed )
	confirm_button.focus_entered.connect( play_audio.bind( button_focus_audio ) )
	confirm_button.mouse_entered.connect( button_mouse_enter.bind( confirm_button ))
	pass


func play_audio( _a : AudioStream ) -> void :
	audio_player.stream = _a
	audio_player.play()


func button_mouse_enter( _b : Button ) -> void:
	_b.grab_focus()
	play_audio( button_focus_audio )


# Players name
func _on_text_edit_text_changed() -> void:
	player_name = name_box.text
	pass # Replace with function body.


# Change scene
func _on_confirm_button_pressed() -> void:
	play_audio(button_pressed_audio)
	if player_name == "" :
		GlobalPlayerManager.character_name = "Cob"
	else :
		GlobalPlayerManager.character_name = player_name
	get_tree().change_scene_to_file( "res://Scenes/Levels/area_1.tscn" )
	#GlobalPlayerManager.player.process_mode = Node.PROCESS_MODE_ALWAYS
	GlobalPlayerManager.player.visible = true
	PlayerHud.visible = true
	Inventory.process_mode = Node.PROCESS_MODE_ALWAYS
	
	pass # Replace with function body.
