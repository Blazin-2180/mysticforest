class_name PlayerCamera extends Camera2D

@export_range (0, 1, 0.05, "or_greater") var shake_power : float = 0.5
@export var shake_max_offset : float = 2.0 # maximum shake in pixels
@export var shake_decay : float = 1.0 # how quickly the shake stops

var shake_trauma : float = 0.0


func _ready() -> void:
	GlobalLevelManager.tilemap_bounds_changed.connect( update_limits )
	update_limits( GlobalLevelManager.current_tilemap_bounds )
	GlobalPlayerManager.camera_shook.connect( add_camera_shake )
	pass

func update_limits ( bounds  : Array [ Vector2 ]) -> void :
	if bounds == []:
		return
	limit_left = int ( bounds [0].x )
	limit_top = int ( bounds [0].y )
	limit_right = int ( bounds [1].x )
	limit_bottom = int ( bounds [1].y )
	pass

func _physics_process( delta : float) -> void:
	zoom()
	if shake_trauma > 0 :
		shake_trauma = max( shake_trauma - shake_decay * delta, 0 )
		shake()
		pass
	pass

func add_camera_shake( value : float ) -> void :
	shake_trauma = value
	pass

func shake() -> void :
	var amount : float = pow( shake_trauma * shake_power, 2 )
	offset = Vector2( randf_range( -1, 1), randf_range( -1, 1) ) * shake_max_offset * amount
	pass

func zoom():
	if Input.is_action_just_released("wheel_down"):
		set_zoom(get_zoom() - Vector2(0.25, 0.25))
	if Input.is_action_just_released("wheel_up"): #and get_zoom() > Vector2.ONE:
		set_zoom(get_zoom() + Vector2(0.25, 0.25))
