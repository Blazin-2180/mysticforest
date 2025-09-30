class_name Bonbon extends CharacterBody2D

@export var target_path : NodePath
@export var follow_distance : float = 1.0
@export var follow_speed : float = 300.0

@onready var animation_player: AnimationPlayer = $Bonbon_Sprite/Bonbon_Animation_Player
@onready var sprite: Sprite2D = $Bonbon_Sprite

var target : Node2D

func ready() -> void:
	animation_player.play( "idle_down" )
	target = get_node( target_path )

func _physics_process( delta : float ) -> void :
	if !target :
		return

	var to_target = target.global_position - global_position
	var direction = to_target.normalized()
	
	#if direction.x != 0 :
		#sprite.flip_h = direction.x < 0
	
	if to_target.length() > follow_distance :
		if to_target.length() > follow_distance + 50 :
			animation_player.play("idle_down")
			follow_speed = 450
		else :
			animation_player.play("idle_down")
		global_position += direction * follow_speed * delta
	else :
		animation_player.play("idle_down")
	move_and_slide()
