class_name ItemEffectHeal extends ItemEffect

@export var heal_amount : int = 1

func use() -> void :
	PlayerHud.update_health_points(heal_amount)
