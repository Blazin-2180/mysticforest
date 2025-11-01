@tool 
@icon("res://Quests/utility_nodes/icons/quest_available.png")
class_name QuestAdvanceTrigger extends QuestNode

signal advanced 

@export_category( "Parent Signal Connection")
@export var signal_name : String = ""

func _ready() -> void:
	if Engine.is_editor_hint() :
		return
	#$Sprite2D.queue_free()
	
	if signal_name != "" :
		if get_parent().has_signal(signal_name ) :
			get_parent().connect( signal_name, advance_quest )
	pass

func advance_quest() -> void :
	if linked_quest == null :
		return
	
	advanced.emit()
	
	var _title : String = linked_quest.title 
	var _step : String = get_step()
	
	if _step == "N/A" :
		_step = ""
		
	QuestManager.update_quest( _title, _step, quest_complete )
	pass




func _on_area_2d_area_entered(area: Area2D) -> void:
	advance_quest()
	queue_free()
	pass # Replace with function body.


func _on_item_pickup_picked_up() -> void:
	advance_quest()
	queue_free()
	pass # Replace with function body.


func _on_treasure_chest_chest_opened() -> void:
	advance_quest()
	queue_free()
	pass # Replace with function body.
