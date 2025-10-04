class_name FollowComponent extends Node

var speed : float = 20.0
var damaged : HurtBox
var start_position 
var target : Player
var bonbon : Bonbon

@onready var parent = get_parent()

func _ready () -> void:
	#damaged.died.connect(disable)
	start_position = parent.position
	pass

func update_velocity () -> void :
	if !target :
		return
	var direction = target.global_position - parent.global_position
	var new_velocity = direction.normalized() * speed
	parent.velocity = new_velocity
	pass

func _physics_process (_delta : float ) -> void:
	update_velocity()
	parent.move_and_slide()
	pass

func disable () -> void :
	process_mode = ProcessMode.PROCESS_MODE_DISABLED

func _on_follow_area_body_entered(body: Node2D) -> void:
	if body is Player : 
		target = body

func _on_follow_area_body_exited(body: Node2D) -> void:
	if body == target :
		target = null
	pass # Replace with function body.
