class_name Stats extends PanelContainer

@onready var label_level : Label = $VBoxContainer/Level/Label2
@onready var label_experience : Label = $VBoxContainer/Experience/Label2
@onready var label_attack : Label = $VBoxContainer/Attack/Label2
@onready var label_defence : Label = $VBoxContainer/Defence/Label2
@onready var label_health: Label = $VBoxContainer/Health/Label2

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
