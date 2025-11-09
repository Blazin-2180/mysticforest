extends CanvasLayer

@onready var health_bar: ProgressBar = $TextureRect/HealthBar
@onready var hp_label: Label = $TextureRect/HealthBar/HealthPoints
@onready var exp_bar: ProgressBar = $Control/ExpBar
@onready var quest_notification: NotificationUI = $Control/QuestNotification
@onready var level: Label = $TextureRect/LevelLabel
@onready var quest_title_label: Label = $QuestTitleLabel
@onready var quest_step_label: Label = $QuestStepLabel

var player : Player = GlobalPlayerManager.player
var quest_log_toggled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	exp_bar.value = GlobalPlayerManager.experience
	level.text = str(GlobalPlayerManager.player.level)
	#quest_title_label.new(Quest)
	#quest_log_toggled = false
	pass


func _process(_delta: float) -> void:
	pass


func update_health_points() -> void :
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	health_bar.max_value = GlobalPlayerManager.max_health_points
	pass


func queue_notification( _title : String, _description : String ) -> void :
	quest_notification.add_notification_to_queue( _title, _description )
	pass

func update_exp() -> void :
	exp_bar.value = GlobalPlayerManager.experience
	exp_bar.max_value = GlobalPlayerManager.level_requirements[ GlobalPlayerManager.player.level ]
	level.text = str(GlobalPlayerManager.player.level)


func _on_quest_log_pressed() -> void:
	QuestLog.show()
	QuestLog.shown.emit()
	pass # Replace with function body.


func _on_inventory_pressed() -> void:
	Inventory.show_inventory()
	pass # Replace with function body.


func _on_menu_pressed() -> void:
	
	pass # Replace with function body.
