extends Node

const PLAYER = preload("uid://d3qi426qtce4j")

var player : Player
var health_points : int = 6
var max_health_points : int = 6
var player_spawned : bool = false

func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	pass
	
func reduce_health_points ( num : int ) -> void :
	health_points -= num
	PlayerHud.update_health_points()
	pass

func add_player_instance () -> void :
	player = PLAYER.instantiate()
	add_child( player )
	pass

func set_health(health_points : int, max_health_points : int ) -> void:
	max_health_points = max_health_points
	health_points = health_points
	reduce_health_points(0)

func set_player_position( _new_position : Vector2) -> void :
	player.global_position = _new_position
	pass

func set_as_parent ( _p : Node2D ) -> void :
	if player.get_parent ():
		player.get_parent().remove_child( player )
	_p.add_child( player )

func unparent_player ( _p : Node2D ) -> void :
	_p.remove_child( player )
