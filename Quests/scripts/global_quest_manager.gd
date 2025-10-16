extends Node

signal quest_updated ( q )

const QUEST_DATA_LOCATION : String = "res://Quests/"

var quests : Array [ Quest ]
var current_quests : Array = []


func _ready() -> void:
	#Gather all quests
	gather_quest_data()
	pass

#Test Key
func _unhandled_input( event : InputEvent ) -> void:
	if event.is_action_pressed("test"):
		#print(find_quest(load("res://Quests/quest_001.tres") as Quest ) )
		#print(find_quest_by_title("tray-zurr"))
		#print("get_quest_index_by_title : ", get_quest_index_by_title( "Tray-zurr" ))
		#print("get_quest_index_by_title : ", get_quest_index_by_title( "Recover lost Tray-zurr" ))
		#print("Before : ", current_quests )
		#update_quest( "Tray-zurr", "Complete Quest", true )
		#update_quest ("Recover lost Tray-zurr" )
		#print("After : ", current_quests )
		#print ("================================")
		pass
	pass

func gather_quest_data() -> void : 
	#Gather all quest resources and add quests to array.
	var quest_files : PackedStringArray = DirAccess.get_files_at( QUEST_DATA_LOCATION )
	quests.clear()
	for q in quest_files :
		quests.append( load(QUEST_DATA_LOCATION + "/" + q) as Quest )
		pass
	print( "Number of quests : ", quests.size() )


#Update the status of a quest. !!! Give the quests an id instead of a title ?? !!!
func update_quest( _title : String, _completed_step : String = "", _is_complete : bool = false ) -> void :
	var quest_index : int = get_quest_index_by_title( _title )
	if quest_index == -1 :
		#Quest was not found and needs adding
		var new_quest : Dictionary = { 
				title = _title, 
				is_complete = _completed_step, 
				completed_steps = [] 
		}
		if _completed_step != "":
			new_quest.completed_steps.append( _completed_step )
			
		current_quests.append( new_quest )
		quest_updated.emit( new_quest )
		#Display a notification that quest was added
		pass
	else :
		#Quest was found, update it
		var q = current_quests[ quest_index ]
		if _completed_step != "" && q.completed_steps.has( _completed_step ) == false :
			q.completed_steps.append( _completed_step )
			pass
		q.is_complete = _is_complete
		quest_updated.emit( q )
		#Display a notification that quest was added or completed.
		if q.is_complete == true : 
			give_quest_rewards( find_quest_by_title( _title ) )
	pass

#Give exp and item rewards to player.
func give_quest_rewards( _q : Quest ) -> void :
	GlobalPlayerManager.reward_experience( _q.reward_experience )
	for i in _q.reward_items :
		GlobalPlayerManager.INVENTORY_DATA.add_item( i.item, i.quantity )
	pass


#Provide a quest and return the current quest associated with it.
func find_quest( _quest : Quest ) -> Dictionary :
	for q in current_quests :
		if q.title.to_lower() == _quest.title.to_lower() :
			return q
	return { title = "Quest Not Found", is_complete = false, completed_steps = [''] }


# Take title and find associated quest resource.
func find_quest_by_title (_title : String) -> Quest :
	for q in quests :
		if q.title.to_lower() == _title.to_lower() :
			return q
	return null


# Find quest by title name, and return index within the current quests array.
func get_quest_index_by_title ( _title : String ) -> int :
	for i in current_quests.size() :
		if current_quests[ i ].title.to_lower() == _title.to_lower() :
			return i
	# Return a -1 if we didnt find a quest with a matching title.
	return -1 


func sort_quests() -> void : 
	# Sort alphabetically or by complete/incomplete
	pass
