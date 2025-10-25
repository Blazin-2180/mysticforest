class_name QuestStepItem extends Control

@onready var label: RichTextLabel = $Label
@onready var sprite: Sprite2D = $Sprite2D

func initialize( step : String, is_complete : bool ) -> void : 
	label.text = step
	if is_complete == true :
		#sprite.frame = 1
		label.bbcode_enabled = true
		label.text = "[s]" + label.text + "[/s]"
		print("enabled")
	else : 
		#sprite.frame = 0
		label.bbcode_enabled = false
		print("disabled")
	pass
