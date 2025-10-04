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
	update_scene_path()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE )
	var save_json = JSON.stringify( current_save )
	file.store_line( save_json )
	game_saved.emit()
	print("game saved")
	pass

func load_game () -> void: 
	# Reads save data
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.READ )
	var json := JSON.new()
	json.parse( file.get_line() )
	var save_dictionary : Dictionary = json.get_data() as Dictionary
	# Updates data to that of the save file.
	current_save = save_dictionary
	
	GlobalLevelManager.load_new_level( current_save.scene_path, "", Vector2.ZERO )
	
	await GlobalLevelManager.level_load_started
	GlobalPlayerManager.set_player_position( Vector2(current_save.player.position_x, current_save.player.position_y ))
	GlobalPlayerManager.set_health (current_save.player.health_points, current_save.player.max_health_points)
	
	await GlobalLevelManager.level_loaded
	game_loaded.emit()
	print("game loaded")
	pass

func update_player_data () -> void :
	var p : Player = GlobalPlayerManager.player
	current_save.player.health_points = GlobalPlayerManager.health_points
	current_save.player.max_health_points = GlobalPlayerManager.max_health_points
	current_save.player.position_x = p.global_position.x
	current_save.player.position_y = p.global_position.y

func update_scene_path () -> void :
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level :
			p = c.scene_file_path
	current_save.scene_path = p
	pass
