extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var hp_label: Label = $Control/HealthBar/HealthPoints

@onready var game_over: Control = $Control/GameOver
@onready var respawn_button: Button = $Control/GameOver/VBoxContainer/RespawnButton
@onready var back_to_title_button: Button = $Control/GameOver/VBoxContainer/BackToTitleButton
@onready var animation_player: AnimationPlayer = $Control/GameOver/GameOverAnimation

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
	animation_player.play( "show_death" )
	await animation_player.animation_finished

func hide_death_screen() -> void :
	game_over.visible = false
	game_over.mouse_filter = Control.MOUSE_FILTER_IGNORE
	game_over.modulate = Color(1, 1, 1, 0)
	pass
