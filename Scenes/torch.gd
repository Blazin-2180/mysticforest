class_name Torch extends Node2D

@onready var light: PointLight2D = $PointLight2D
@onready var animation: AnimationPlayer = $AnimationPlayer

func _process( _delta : float) -> void:
	
	if GlobalLevelManager.time_of_day == "day" || GlobalLevelManager.weather == "Rain":
		light.visible = false
		animation.play("extinguished")

	elif GlobalLevelManager.time_of_day == "night" || GlobalLevelManager.weather == "None" :
		light.visible = true
		animation.play("default")
