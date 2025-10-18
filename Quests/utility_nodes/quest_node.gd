@tool
class_name QuestNode extends Node2D

@export var linked_quest : Quest = null : set = _set_quest
@export var quest_step : int = 0 : set = _set_step
@export var quest_complete : bool = false : set = _set_complete

@export_category( "Information Only" )
@export_multiline var settings_summary : String

func _set_quest( _value : Quest ) -> void :
	linked_quest = _value
	quest_step = 0
	update_summary()
	pass

func _set_step( _value : int ) -> void :
	quest_step = clamp( _value, 0, get_step_count())
	update_summary()
	pass

func get_step_count() -> int :
	if linked_quest == null :
		return 0 
	else :
		return linked_quest.steps.size()

func _set_complete( _value : bool ) -> void :
	quest_complete = _value
	update_summary()
	pass
   
func update_summary() -> void :
	settings_summary = "UPDATE QUEST : \nQuest : " +linked_quest.title + "\n"
	settings_summary += "Step : " + str( quest_step ) + " " + get_step() + "\n"
	settings_summary += "Complete : " + str( quest_complete )
	pass

func get_step() -> String :
	if quest_step != 0 && quest_step <= get_step_count():
		return linked_quest.steps[ quest_step - 1 ]
	else :
		return "N/A"
