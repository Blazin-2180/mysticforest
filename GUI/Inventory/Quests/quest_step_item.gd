class_name QuestStepItem extends Control

@onready var label: RichTextLabel = $Label

func initialize( step : String, is_complete : bool ) -> void : 
	label.text = step
	if is_complete == true :
		label.bbcode_enabled = true
		label.text = "[s]" + label.text + "[/s]"
		label.modulate = Color.DIM_GRAY
	else : 
		label.bbcode_enabled = false
	pass
