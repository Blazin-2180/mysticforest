class_name HitBox extends Area2D

signal damaged ( damage : int )

func _ready() -> void:
	pass

func _process( _delta : float ) -> void:
	pass
<<<<<<< Updated upstream
func TakeDamage( damage : int ) -> void :
	#print("take damage ", damage)
	damaged.emit(damage)
=======

func take_damage ( damage : int ) -> void :
	damaged.emit( damage )
>>>>>>> Stashed changes
