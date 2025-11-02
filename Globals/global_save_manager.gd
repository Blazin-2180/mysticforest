extends Node

const SAVE_PATH = "user://"

signal game_loaded
signal game_saved

var current_save : Dictionary = {
	scene_path = "",
	player = {
		name = GlobalPlayerManager.character_name,
		level = 1,
		experience = 0,
		attack = 1,
		defence = 1,
		health_points = 1,
		max_health_points = 1,
		position_x = 0,
		position_y = 0
	},
	inventory = [],
	persistence = [],
	quests = [],
}

func save_game() -> void :
	update_player_data()
	update_scene_path()
	update_item_data()
	update_quest_data()
	var file := FileAccess.open( SAVE_PATH + "save.sav", FileAccess.WRITE )
	var save_json = JSON.stringify( current_save )
	file.store_line( save_json )
	game_saved.emit()
	print("game saved")
	pass

func get_save_file() -> FileAccess : 
	return FileAccess.open( SAVE_PATH + "save.sav", FileAccess.READ )

func load_game () -> void: 
	var p : Player = GlobalPlayerManager.player
	# Reads save data
	var file := get_save_file()
	var json := JSON.new()
	json.parse( file.get_line() )
	var save_dictionary : Dictionary = json.get_data() as Dictionary
	# Updates data to that of the save file.
	current_save = save_dictionary
	
	GlobalLevelManager.load_new_level( current_save.scene_path, "", Vector2.ZERO )
	
	await GlobalLevelManager.level_load_started
	GlobalPlayerManager.set_player_position( Vector2(current_save.player.position_x, current_save.player.position_y ))
	GlobalPlayerManager.set_health (current_save.player.health_points, current_save.player.max_health_points)
	GlobalPlayerManager.INVENTORY_DATA.parse_save_data( current_save.items )
	GlobalPlayerManager.character_name = current_save.player.name
	p.level = current_save.player.level
	GlobalPlayerManager.experience = current_save.player.experience
	p.attack = current_save.player.attack
	p.defence = current_save.player.defence
	QuestManager.current_quests = current_save.quests
	
	await GlobalLevelManager.level_loaded
	game_loaded.emit()
	print("game loaded")
	pass

func update_player_data () -> void :
	var p : Player = GlobalPlayerManager.player
	current_save.player.health_points = GlobalPlayerManager.health_points
	current_save.player.name = GlobalPlayerManager.character_name
	current_save.player.max_health_points = GlobalPlayerManager.max_health_points
	current_save.player.position_x = p.global_position.x
	current_save.player.position_y = p.global_position.y
	current_save.player.level = p.level
	current_save.player.experience = GlobalPlayerManager.experience
	current_save.player.attack = p.attack
	current_save.player.defence = p.defence

func update_scene_path () -> void :
	var p : String = ""
	for c in get_tree().root.get_children():
		if c is Level :
			p = c.scene_file_path
	current_save.scene_path = p
	pass

func update_item_data() -> void : 
	current_save.items = GlobalPlayerManager.INVENTORY_DATA.get_save_data()

func add_persistent_value( value : String) -> void :
	if check_persistent_value( value ) == false :
		current_save.persistence.append( value )
	pass

func check_persistent_value( value : String ) -> bool :
	var p = current_save.persistence as Array
	return p.has( value )

func update_quest_data() -> void : 
	current_save.quests = QuestManager.current_quests
	pass
