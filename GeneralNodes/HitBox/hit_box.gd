class_name HitBox extends Area2D

signal damaged ( damage : int )

func _ready() -> void:
	pass

func _process( _delta : float ) -> void:
	pass
func TakeDamage( damage : int ) -> void :
	#print("take damage ", damage)
	damaged.emit(damage)
