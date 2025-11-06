class_name Stats extends PanelContainer

var inventory : InventoryData

@onready var label_level : Label = %Label_level
@onready var label_experience : Label = %Label_experience
@onready var label_attack : Label = %Label_attack
@onready var label_defence : Label = %Label_defence
@onready var label_health: Label = %Label_health

@onready var attack_modifier_label: Label = %attack_modifier_label
@onready var defence_modifier_label: Label = %defence_modifier_label
@onready var health_modifier_label: Label = %health_modifier_label


func _ready() -> void:
	Inventory.shown.connect( update_stats )
	Inventory.preview_stats_changed.connect ( _on_preview_stats_changed )
	inventory = GlobalPlayerManager.INVENTORY_DATA
	inventory.equipment_changed.connect( update_stats )


func update_stats() -> void :
	var _p : Player = GlobalPlayerManager.player
	label_level.text = str(_p.level)
	
	if _p.level < GlobalPlayerManager.level_requirements.size() :
		label_experience.text = str( GlobalPlayerManager.experience )
	else : 
		label_experience.text = "Max"
	
	label_attack.text = str( _p.attack + inventory.get_attack_bonus() )
	label_defence.text = str( _p.defence + inventory.get_defence_bonus() )
	label_health.text = str( GlobalPlayerManager.max_health_points + inventory.get_health_bonus() )
	pass

func _on_preview_stats_changed( item : ItemData ) -> void :
	attack_modifier_label.text = ""
	defence_modifier_label.text = ""
	health_modifier_label.text = ""
	
	if !item is EquipableItemData :
		return
		
	var equipment : EquipableItemData = item 
	var attack_delta : int = inventory.get_attack_bonus_difference( equipment)
	var defence_delta : int = inventory.get_defence_bonus_difference( equipment)
	var health_delta : int = inventory.get_health_bonus_difference( equipment)


	update_change_label( attack_modifier_label, attack_delta)
	update_change_label( defence_modifier_label, defence_delta)
	update_change_label( health_modifier_label, health_delta)
	
	pass


func update_change_label( label : Label, value : int ) -> void : 
	if value > 0 :
		label.text = "+" + str( value )
		label.modulate = Color.WEB_GREEN
	elif value < 0 :
		label.text = str( value )
		label.modulate = Color.DARK_RED
	pass
