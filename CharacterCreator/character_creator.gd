class_name CharacterCreator extends Node2D

@onready var name_box : TextEdit = $CanvasLayer/Control/ColorRect/Details/NameBox

var player_name = ""

func _ready() -> void:
	get_tree().paused = true
	GlobalPlayerManager.player.visible = false
	PlayerHud.visible = false
	Inventory.process_mode = Node.PROCESS_MODE_DISABLED
	pass


# Players name
func _on_text_edit_text_changed() -> void:
	player_name = name_box.text
	pass # Replace with function body.


# Change scene
func _on_confirm_button_pressed() -> void:
	GlobalPlayerManager.character_name = player_name
	get_tree().change_scene_to_file("res://Scenes/Levels/area_1.tscn")
	GlobalPlayerManager.player.visible = true
	PlayerHud.visible = true
	Inventory.process_mode = Node.PROCESS_MODE_ALWAYS
	pass # Replace with function body.
