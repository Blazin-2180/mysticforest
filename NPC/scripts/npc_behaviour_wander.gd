@tool
extends NPCBehaviour

#region /// Constant Variables
const DIRECTIONS = [Vector2.UP, Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT]
#endregion

#region /// Export Variables
@export var wander_range : int = 2 : set = _set_wander_range
@export var wander_speed : float = 30.0
@export var wander_duration : float = 1.0
@export var idle_duration : float = 1.0
#endregion

#region
var original_position : Vector2
#endregion


func _ready() -> void:
	if Engine.is_editor_hint() :
		return
	super()
	$CollisionShape2D.queue_free()
	original_position = npc.global_position


func _process(_delta: float) -> void:
	if Engine.is_editor_hint() :
		return


func start() -> void :
	#IDLE PHASE
	if npc.do_behaviour == false :
		return
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	await get_tree().create_timer( randf() * idle_duration + idle_duration  * 0.5 ).timeout
	
	#WALK PHASE
	if npc.do_behaviour == false :
		return
	npc.state = "walk"
	var _direction : Vector2 = DIRECTIONS[randi_range( 0, 3 )]
	if abs( global_position.distance_to( original_position ) ) > wander_range * 16 :
		var direction_to_area : Vector2 = global_position.direction_to( original_position )
		var best_directions : Array[ float ]
		for d in DIRECTIONS :
			best_directions.append( d.dot ( direction_to_area ) )
		_direction = DIRECTIONS[ best_directions.find( best_directions.max() ) ]
		
	npc.direction = _direction
	npc.velocity = wander_speed * _direction
	npc.update_direction( global_position + _direction)
	npc.update_animation()
	
	await get_tree().create_timer( randf() * wander_duration + wander_duration  * 0.5 ).timeout
	#REPEAT
	if npc.do_behaviour == false :
		return
	start()
	pass


func _set_wander_range( v : int ) -> void :
	wander_range = v
	$CollisionShape2D.shape.radius = v * 16.0
