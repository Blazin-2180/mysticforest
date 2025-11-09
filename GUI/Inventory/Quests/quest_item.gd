class_name QuestItem extends Button

var quest : Quest

@onready var title_label: Label = $TitleLabel
#@onready var step_label: Label = $StepLabel

func initialize( q_data : Quest, q_state ) -> void :
	quest = q_data
	title_label.text = q_data.title
	PlayerHud.quest_title_label.text = q_data.title
	
	#if q_state.is_complete :
		#step_label.text = "Completed"
		#step_label.modulate = Color.WEB_GREEN
	#pass
