extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		health_points = 6,
		max_health_points = 6,
		position_x = 0,
		position_y = 0
	},
	items = [],
	persistence = [],
	quests = [],
}

func save_game() -> void :
	update_player_data()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE )
	var save_json = JSON.stringify( current_save )
	file.store_line( save_json )
	game_saved.emit()
	print("game saved")
	pass

func load_game () -> void: 
	print("game loaded")
	pass

func update_player_data () -> void :
	var p : Player = GlobalPlayerManager.player
	current_save.player.health_points = GlobalPlayerManager.health_points
	current_save.player.max_health_points = GlobalPlayerManager.max_health_points
	current_save.player.position_x = p.global_position.x
	current_save.player.position_y = p.global_position.y
