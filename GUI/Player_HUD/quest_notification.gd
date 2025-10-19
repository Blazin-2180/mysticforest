class_name NotificationUI extends Control

var notification_queue : Array

@onready var panel_container: PanelContainer = $PanelContainer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var quest_title: Label = $PanelContainer/VBoxContainer/QuestTitle
@onready var quest_desc: Label = $PanelContainer/VBoxContainer/QuestDesc

func _ready() -> void:
	panel_container.visible = false
	animation_player.animation_finished.connect( notification_animation_finished )
	

func add_notification_to_queue( _title : String, _description : String ) -> void :
	notification_queue.append( {
		title = _title,
		description = _description
	} )
	
	if animation_player.is_playing() :
		return
	display_notification()
	pass

func display_notification() -> void :
	var _n = notification_queue.pop_front()
	if _n == null :
		return
	quest_title.text = _n.title
	quest_desc.text = _n.description
	animation_player.play( "show_notification" )
	pass

func notification_animation_finished( _animation : String ) -> void :
	display_notification()
	pass
