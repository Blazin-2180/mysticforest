class_name DayNightCycle extends CanvasModulate


@export var hours_per_daytime : int = 12
@export var hours_per_nighttime : int = 10

@export var seconds_per_hour : float = 60.0
@export var starting_hour : int = 8 #6

@export var day_color : Color = Color( 1,1,1 )
@export var night_color : Color = Color( 0.1, 0.1, 0.2 )

var time_in_hours : float = 0.0
var total_day_length : float = 0.0

func _ready() -> void:
	total_day_length = hours_per_daytime + hours_per_nighttime
	time_in_hours = fmod( starting_hour, total_day_length )

func _process(delta: float) -> void:
	time_in_hours += delta / seconds_per_hour
	time_in_hours = fmod( time_in_hours, total_day_length )
	
	var blend_factor : float = 0.0
	
	if time_in_hours < hours_per_daytime :
		var t = time_in_hours / hours_per_daytime
		blend_factor = sin( t * PI )
	else : 
		var t = ( time_in_hours - hours_per_daytime ) / hours_per_nighttime
		blend_factor = sin( t * PI )
	
	color = night_color.lerp(day_color, blend_factor)

func get_current_hour() -> int :
	return int( time_in_hours )

func get_current_minute() -> int :
	return int((time_in_hours - int(time_in_hours)) * 60 )

func is_daytime() -> bool :
	return time_in_hours < hours_per_daytime
