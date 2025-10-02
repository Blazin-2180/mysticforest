extends Node

var player : Player
var health_points : int = 6
var max_health_points : int = 6

func _ready() -> void:
	pass
	
func reduce_health_points ( num : int ) -> void :
	health_points -= num
	PlayerHud.update_health_points()
	pass
