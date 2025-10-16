extends CanvasLayer

#region /// Variables
var inventory_show : bool = false
var is_paused : bool = false
#endregion

#region /// On Ready Variables
@onready var inventory_slot: Button = $Control/ColorRect/Panel/GridContainer/InventorySlot
@onready var item_description: Label = $Control/TabContainer/Inventory/ItemDescription
@onready var button_load: Button = $Control/TabContainer/System/VBoxContainer/Button_Load
#endregion

#region /// Signals
signal shown
signal hidden
#endregion

func _ready() -> void:
	hide_inventory()
	button_load.pressed.connect(_on_load_pressed)
	pass

func _unhandled_input ( event : InputEvent ) -> void:
	if event.is_action_pressed( "inventory" ) :
		if inventory_show == false :
			show_inventory()
		else : 
			hide_inventory()
			get_viewport().set_input_as_handled()

func show_inventory () -> void :
	visible = true
	inventory_show = true
	shown.emit()
	print("show")

func hide_inventory () -> void : 
	visible = false
	inventory_show = false
	hidden.emit()
	print("hide")

func update_item_description (new_text : String) -> void :
	item_description.text = new_text
	
func _on_load_pressed () -> void :
	if is_paused == false :
		return
	GlobalSaveManager.load_game()
	await GlobalLevelManager.level_load_started
	hide_pause_menu()
	pass

func hide_pause_menu () -> void : 
	get_tree().paused = false
	visible = false
	is_paused = false

func _on_button_exit_pressed() -> void:
	get_tree().quit()
#func play_audio( audio : AudioStream) -> void :
	#audio_stream_player.stream = audio
	#audio_stream_player.play()
	#pass
