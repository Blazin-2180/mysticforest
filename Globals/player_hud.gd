extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var hp_label: Label = $Control/HealthBar/HealthPoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass
	
func _process(_delta: float) -> void:
	pass

func update_health_points() -> void :
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass
