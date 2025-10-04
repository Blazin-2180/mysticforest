extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var hp_label: Label = $Control/HealthBar/HealthPoints

@onready var death: Control = $Control/Death
@onready var respawn_button: Button = $Control/Death/VBoxContainer/RespawnButton
@onready var back_to_title_button: Button = $Control/Death/VBoxContainer/BackToTitleButton
@onready var game_over: AnimationPlayer = $Control/Death/GameOverAnimation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_death_screen()
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass
	
func _process(_delta: float) -> void:
	pass

func update_health_points() -> void :
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass

func show_death_screen() -> void :
	game_over.visible = true
	game_over.mouse_filter = Control.MOUSE_FILTER_STOP
	game_over.play("show_death")
	await game_over.animation_finished

func hide_death_screen() -> void :
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1,1,1, 0)
	pass
