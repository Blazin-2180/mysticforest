class_name Level extends Node2D

func _ready() -> void:
	self.y_sort_enabled = true
	self.z_as_relative = false
	GlobalPlayerManager.set_as_parent( self )
	GlobalLevelManager.level_load_started.connect(_free_level)
	pass

func _free_level () -> void :
	GlobalPlayerManager.unparent_player( self )
	queue_free()
	pass
#If having an issue with the y-sorting of the fences/trees and stuff :
#Ok and the Fences and logs, if you go into your Tileset you can paint the Y-Sort Origin.  
#Put those at -8 so the y-sort is near the top of the tile and then you should have it looking how you want it to.

func _process(delta: float) -> void:
	print($DayNightCycle.get_current_hour(), "", "",
	$DayNightCycle.get_current_minute(), "", "",
	$DayNightCycle.is_daytime())
