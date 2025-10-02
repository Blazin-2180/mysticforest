extends CanvasLayer

@onready var health_bar: ProgressBar = $Control/HealthBar
@onready var hp_label: Label = $Control/HealthBar/HealthPoints

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_bar.value = GlobalPlayerManager.health_points
	hp_label.text = str(GlobalPlayerManager.health_points, "/", GlobalPlayerManager.max_health_points)
	pass # Replace with function body.
	
func _process(_delta: float) -> void:
	pass

#func update_health_points ( delta : int) -> void :
	#health_bar.value = GlobalPlayerManager.health_points
	#pass
