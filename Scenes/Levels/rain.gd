class_name WeatherRain extends GPUParticles2D

var current_weather : String = "None"

@onready var timer: Timer = $Timer
@onready var color: ColorRect = $ColorRect

func _ready() -> void :
	if current_weather == "None" :
		self.visible = false
		color.visible = false
	if current_weather == "Rain" :
		self.visible = true
		color.visible = true
	pass


func _on_timer_timeout() -> void :
	if current_weather == "None" :
		current_weather = "Rain"
		timer.wait_time = randi_range( 10, 30 ) # 10 seconds to 30 seconds
		timer.start()
	elif current_weather == "Rain" : 
		current_weather = "None"
		timer.wait_time = randi_range( 20, 60 ) #20 seconds to 60 seconds
		timer.start()
	pass # Replace with function body.


func _process( _delta : float) -> void :
	GlobalLevelManager.weather = current_weather
	if current_weather == "None" :
		self.visible = false
		color.visible = false
	if current_weather == "Rain" :
		self.visible = true
		color.visible = true
