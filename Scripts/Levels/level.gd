class_name Level extends Node2D

@export var music : AudioStream

func _ready() -> void:
	self.y_sort_enabled = true
	self.z_as_relative = false
	GlobalPlayerManager.set_as_parent( self )
	GlobalLevelManager.level_load_started.connect(_free_level)
	AudioManager.play_music( music )
	pass

func _free_level () -> void :
	GlobalPlayerManager.unparent_player( self )
	queue_free()
	pass
