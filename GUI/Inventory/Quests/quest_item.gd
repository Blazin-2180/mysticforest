class_name QuestItem extends Button

var quest : Quest

@onready var title_label: Label = $TitleLabel

func initialize( q_data : Quest, q_state ) -> void :
	quest = q_data
	title_label.text = q_data.title
	PlayerHud.quest_title_label.text = q_data.title
	PlayerHud.quest_step_label.text = str(q_data.steps)
	
	if q_state.is_complete :
		title_label.modulate = Color.DIM_GRAY
	pass
