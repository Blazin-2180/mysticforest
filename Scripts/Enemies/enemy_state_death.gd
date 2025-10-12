class_name EnemyStateDeath extends EnemyState

#region /// Constants 
const PICKUP = preload("res://Items/Item_Pickup/item_pickup.tscn")
#endregion

#region /// Export Variables
@export var animation_name : String = "death"
@export var knockback_speed : float = 200.0
@export var decelerate_speed : float = 10.0
@export_category("AI")
@export_category("Item Drops")
@export var drops : Array [ DropData ]
#endregion

#region /// Variables
var _damage_position : Vector2
var _direction : Vector2
#endregion

func init() -> void :
	enemy.enemy_death.connect ( _on_enemy_death )
	pass

func enter() -> void : 
	enemy.invulnerable = true
	_direction = enemy.global_position.direction_to( _damage_position )
	enemy.set_direction ( _direction )
	enemy.velocity = _direction * -knockback_speed
	enemy.update_animation ( animation_name )
	enemy.animation_player.animation_finished.connect( _on_animation_finished )
	disable_hurt_box()
	drop_items()
	pass

func process ( _delta : float ) -> EnemyState :
	enemy.velocity -= enemy.velocity * decelerate_speed * _delta
	return null

func physics( _delta : float ) -> EnemyState :
	return null
	
func _on_enemy_death ( hurt_box : HurtBox ) -> void :
	_damage_position = hurt_box.global_position
	enemy_state_machine.change_state( self )

func _on_animation_finished ( _a : String ) -> void :
	enemy.queue_free()

func _exit() -> void:
	pass

func disable_hurt_box() -> void : 
	var hurt_box : HurtBox = enemy.get_node_or_null("HurtBox")
	if hurt_box :
		hurt_box.monitoring = false

func drop_items() -> void :
	if drops.size() == 0 :
		return
	for d in drops.size() :
		if drops[ d ] == null || drops[ d ].item == null :
			continue
		var drop_count : int = drops[ d ].get_drop_count()
		for e in drop_count :
			var drop : ItemPickup = PICKUP.instantiate() as ItemPickup
			drop.item_data = drops[ d ].item
			enemy.get_parent().call_deferred( "add_child", drop )
			drop.global_position = enemy.global_position
			drop.velocity = enemy.velocity.rotated(randf_range(-1.5, 1.5)) * randf_range(0.9, 1.5)
