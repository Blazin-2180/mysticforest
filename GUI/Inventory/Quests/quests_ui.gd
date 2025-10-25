class_name QuestsUI extends Control

const QUEST_ITEM : PackedScene = preload("res://GUI/Inventory/Quests/quest_item.tscn")
const QUEST_STEP_ITEM : PackedScene = preload("res://GUI/Inventory/Quests/quest_step_item.tscn")

@onready var quest_item_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer
@onready var quest_details_container: VBoxContainer = $VBoxContainer
@onready var title_label: Label = $VBoxContainer/TitleLabel
@onready var description_label: Label = $VBoxContainer/QuestDescriptionLabel

func _ready() -> void:
	clear_quest_details()
	visibility_changed.connect( _on_visible_changed )
	pass

func _on_visible_changed() -> void :
	for i in quest_item_container.get_children():
		i.queue_free()
	if visible == true :
		# Update the quest list
		for q in QuestManager.current_quests :
			var quest_data : Quest = QuestManager.find_quest_by_title( q.title )
			if quest_data == null :
				continue
			var new_q_item : QuestItem = QUEST_ITEM.instantiate()
			quest_item_container.add_child( new_q_item )
			new_q_item.initialize( quest_data, q )
			# Connect to the focus entered of each quest
			new_q_item.focus_entered.connect ( update_quest_details.bind( new_q_item.quest ) )
	pass

func update_quest_details( q : Quest ) -> void :
	#Clear quest details
	clear_quest_details()
	
	title_label.text = q.title
	description_label.text = q.description
	var quest_save = QuestManager.find_quest( q )
	for step in q.steps :
		var new_step : QuestStepItem = QUEST_STEP_ITEM.instantiate()
		var step_is_complete : bool = false
		if quest_save.title != "Not Found" :
			step_is_complete = quest_save.completed_steps.has( step )
		quest_details_container.add_child( new_step)
		new_step.initialize(step, step_is_complete)
	pass

func clear_quest_details() -> void :
	title_label.text = ""
	description_label.text = ""
	for c in quest_details_container.get_children() :
		if c is QuestStepItem :
			c.queue_free()
	pass
