extends CanvasLayer

#region /// Variables
var quest_log_show : bool = false
#endregion

#region /// On Ready Variables
@onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
@onready var quest_item: QuestItem = $Control/Quests/ScrollContainer/MarginContainer/VBoxContainer/QuestItem
#endregion

@export var button_focus_audio : AudioStream
@export var button_pressed_audio : AudioStream

#region /// Signals
signal shown
signal hidden
#endregion

func _ready() -> void:
	hide_quest_log()
	pass

func _unhandled_input ( event : InputEvent ) -> void:
	if event.is_action_pressed( "quest_log" ):
		if quest_log_show == false :
			if DialogSystem.is_active:
				return
			show_quest_log()
		else : 
			hide_quest_log()
			get_viewport().set_input_as_handled()

func show_quest_log () -> void :
	visible = true
	quest_log_show = true
	shown.emit()


func hide_quest_log () -> void : 
	visible = false
	quest_log_show = false
	hidden.emit()


func play_audio( audio : AudioStream ) -> void :
	audio_stream.stream = audio
	audio_stream.play()
	pass


func _on_button_pressed() -> void:
	hide_quest_log()
	pass # Replace with function body.


func _on_quest_item_focus_entered( _b : QuestItem ) -> void:
	_b.grab_focus()
	pass # Replace with function body.
