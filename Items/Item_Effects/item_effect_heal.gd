class_name ItemEffectHeal extends ItemEffect

@export var heal_amount : int = 1
@export var audio : AudioStream

func use() -> void :
	heal_amount = GlobalPlayerManager.max_health_points / 2
	GlobalPlayerManager.increase_health_points(heal_amount)
	Inventory.play_audio( audio )
