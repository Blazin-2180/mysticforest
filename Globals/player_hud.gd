extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var hp_label: Label = $Control/HealthBar/HealthPoints

@onready var death: Control = $Control/Death
@onready var respawn_button: Button = $Control/Death/VBoxContainer/RespawnButton
@onready var back_to_title_button: Button = $Control/Death/VBoxContainer/BackToTitleButton
@onready var animation_player: AnimationPlayer = $Control/Death/GameOverAnimation
@onready var quest_notification: NotificationUI = $Control/QuestNotification

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#hide_death_screen()
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass
	
func _process(_delta: float) -> void:
	pass

func update_health_points() -> void :
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass

#func show_death_screen() -> void :
	#death.visible = true
	#death.mouse_filter = Control.MOUSE_FILTER_STOP
	#animation_player.play("show_death")
	#await animation_player.animation_finished

#func hide_death_screen() -> void :
	#death.visible = false
	#death.mouse_filter = Control.MOUSE_FILTER_IGNORE
	#death.modulate = Color(1,1,1, 0)
	#pass

func queue_notification( _title : String, _description : String ) -> void :
	quest_notification.add_notification_to_queue( _title, _description )
	pass
