@tool 
@icon("res://Quests/utility_nodes/icons/quest_complete.png")
class_name QuestActivatedSwitch extends QuestNode

enum CheckType { HAS_QUEST, QUEST_STEP_COMPLETE, ON_CURRENT_QUEST_STEP, QUEST_COMPLETE }

signal is_activated_changed( value : bool )

@export var check_type : CheckType = CheckType.HAS_QUEST : set = _set_check_type
@export var remove_when_activated : bool = false
@export var react_to_global_signal : bool = false

var is_activated : bool = false

func _ready() -> void:
	if Engine.is_editor_hint() :
		return
	#$Sprite2D.queue_free()
	
	#Connect to the global signal if react to global signal is true
	if react_to_global_signal == true :
		QuestManager.quest_updated.connect( _on_quest_updated )
	check_is_activated()
	pass

func check_is_activated() -> void :
	#Get the saved quest
	var _quest : Dictionary = QuestManager.find_quest( linked_quest )
	
	if _quest.title != "Quest Not Found" :
		if check_type == CheckType.HAS_QUEST :
			# We already passed this test, so we are done!
			set_is_activated( true )

		elif check_type == CheckType.QUEST_COMPLETE :
			#Set is activated based on if the quest complete values match
			var is_complete : bool = false
			if _quest.is_complete is bool :
				is_complete = _quest.is_complete
			set_is_activated( is_complete )

		elif check_type == CheckType.QUEST_STEP_COMPLETE :
			if quest_step > 0 :
				if _quest.completed_steps.has(get_step()) == true :
					set_is_activated( true )
				else : 
					set_is_activated( false )
			else : 
				set_is_activated( false )

		elif check_type == CheckType.ON_CURRENT_QUEST_STEP :
			var step : String = get_step()
			if step == "N/A":
				set_is_activated( false )
				pass
			else : 
				if _quest.completed_steps.has( step ) :
					set_is_activated( false )
				else :
					var previous_step : String = get_previous_step()
					if previous_step == "N/A" :
						set_is_activated( true )
					elif _quest.completed_steps.has( previous_step.to_lower() ) :
						set_is_activated( true )
					else : 
						set_is_activated( false )
			pass
		pass
	else : 
		set_is_activated( false )
	pass

func set_is_activated( _value : bool ) -> void : 
	is_activated = _value
	is_activated_changed.emit( _value )
	if is_activated == true :
		if remove_when_activated == true :
			#hide children
			hide_children()
		else :
			#show children
			show_children()
	else : 
		if remove_when_activated == true :
			#show children
			show_children()
		else :
			#hide children
			hide_children()
	pass

func show_children() -> void : 
	for c in get_children() :
		c.visible = true
		c.process_mode = Node.PROCESS_MODE_INHERIT
	pass

func hide_children() -> void :
	#set_deferred is used due to it relating to a signal
	for c in get_children() :
		c.set_deferred( "visible", false )
		c.set_deferred( "process_mode", Node.PROCESS_MODE_DISABLED )
	pass

func _on_quest_updated( _quest : Dictionary ) -> void :
	check_is_activated()
	pass

func _set_check_type( value : CheckType ) -> void :
	check_type = value
	update_summary()
	pass

func update_summary() -> void :
	if linked_quest == null :
		settings_summary = "Select a Quest"
		return
	settings_summary = "UPDATE QUEST : \nQuest : " + linked_quest.title + "\n"
	if check_type == CheckType.HAS_QUEST :
		settings_summary += "Checking if player has quest"
	elif check_type == CheckType.QUEST_STEP_COMPLETE :
		settings_summary += "Checking if player has completed step : " + get_step()
	elif check_type == CheckType.ON_CURRENT_QUEST_STEP :
		settings_summary += "Check if player is on Step : " + get_step()
	elif check_type == CheckType.QUEST_COMPLETE :
		settings_summary += "Checking if quest has been completed."
	pass
