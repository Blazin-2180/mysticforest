extends Node

const PLAYER = preload("uid://d3qi426qtce4j")
const INVENTORY_DATA : InventoryData = preload("res://GUI/Inventory/player_inventory.tres")

signal interact_pressed
signal player_levelled_up
signal camera_shook ( trauma : float )

var player : Player
var health_points : int = 6
var max_health_points : int = 6
var player_spawned : bool = false
var experience : int = 0
var level_requirements = [ 0, 50, 100, 200, 400, 800, 1500, 3000, 6000, 12000, 25000 ]
#var level_requirements = [0, 5, 10, 20, 25] # for testing


func _ready() -> void:
	add_player_instance()
	await get_tree().create_timer(0.2).timeout
	player_spawned = true
	pass

func reduce_health_points ( num : int ) -> void :
	health_points -= num
	PlayerHud.update_health_points()
	pass

func increase_health_points(num: int) -> void:
	health_points = min(health_points + num, max_health_points)
	PlayerHud.update_health_points()

func increase_experience(num: int) -> void:
	experience = min(experience + num, level_requirements[ player.level ])
	PlayerHud.update_exp()


func reward_experience( _exp : int ) -> void :
	experience += _exp
	# Check for level advancement
	check_level_advance()
	PlayerHud.update_exp()
	pass

func check_level_advance() -> void :
	if player.level >= level_requirements.size() :
		return
	if experience >= level_requirements[ player.level ] :
		player.level += 1
		player.attack += 1
		player.defence += 1
		max_health_points += 2
		player_levelled_up.emit()
		check_level_advance()

func add_player_instance () -> void :
	player = PLAYER.instantiate()
	add_child( player )
	pass

func set_health(_health_points : int, _max_health_points : int ) -> void:
	max_health_points = _max_health_points
	health_points = _health_points
	PlayerHud.update_health_points()

func set_experience( _experience : int, _max_experience : int) -> void :
	level_requirements[player.level] = _max_experience
	experience = _experience
	PlayerHud.update_exp()
	check_level_advance()

func set_player_position( _new_position : Vector2) -> void :
	player.global_position = _new_position
	pass

func set_as_parent ( _p : Node2D ) -> void :
	if player.get_parent ():
		player.get_parent().remove_child( player )
	_p.add_child( player )

func unparent_player ( _p : Node2D ) -> void :
	_p.remove_child( player )

func play_audio( _audio : AudioStream ) -> void :
	player.audio.stream = _audio
	player.audio.play()

func shake_camera( trauma : float = 1 ) -> void :
	camera_shook.emit( clampi ( trauma, 0, 1 ) )
