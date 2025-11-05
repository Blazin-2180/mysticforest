class_name Stats extends PanelContainer

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
	
func update_stats() -> void :
	var _p : Player = GlobalPlayerManager.player
	label_level.text = str(_p.level)
	
	if _p.level < GlobalPlayerManager.level_requirements.size() :
		label_experience.text = str(GlobalPlayerManager.experience)
	else : 
		label_experience.text = "Max"
	
	label_attack.text = str(_p.attack)
	label_defence.text = str(_p.defence)
	label_health.text = str(GlobalPlayerManager.max_health_points)
	pass
