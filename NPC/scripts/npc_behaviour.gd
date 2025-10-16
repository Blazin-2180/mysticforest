@icon("res://NPC/icons/npc_behavior.svg")
class_name NPCBehaviour extends Node2D

var npc : NPC

func _ready() -> void:
	var p = get_parent()
	if p is NPC :
		npc = p as NPC
		npc.behaviour_enabled.connect(start)

func start() -> void :
	pass
