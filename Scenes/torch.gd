class_name Torch extends Node2D

@onready var light: PointLight2D = $PointLight2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process( _delta : float) -> void:
	
	if GlobalLevelManager.time_of_day == "day" || GlobalLevelManager.weather == "Rain":
		light.visible = false

	elif GlobalLevelManager.time_of_day == "night" || GlobalLevelManager.weather == "None" :
		light.visible = true
