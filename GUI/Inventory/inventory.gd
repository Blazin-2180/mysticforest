extends CanvasLayer

#region /// Variables
var inventory_show : bool = false
var is_paused : bool = false
#endregion

#region /// On Ready Variables
@onready var inventory_slot: Button = $Control/TabContainer/Inventory/Panel/GridContainer/InventorySlot
@onready var item_description: Label = $Control/TabContainer/Inventory/ItemDescription
@onready var button_load: Button = $Control/TabContainer/System/VBoxContainer/Button_Load
@onready var tab_container: TabContainer = $Control/TabContainer
#endregion

#region /// Signals
signal shown
signal hidden
#endregion

func _ready() -> void:
	hide_inventory()
	pass

func _unhandled_input ( event : InputEvent ) -> void:
	if event.is_action_pressed( "inventory" ) :
		if inventory_show == false :
			if DialogSystem.is_active:
				return
			show_inventory()
		else : 
			hide_inventory()
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("right_bumper") :
		change_tab( 1 )
	elif event.is_action_pressed("left_bumper") :
		change_tab( -1 )

func show_inventory () -> void :
	visible = true
	inventory_show = true
	tab_container.current_tab = 0
	shown.emit()

func hide_inventory () -> void : 
	visible = false
	inventory_show = false
	hidden.emit()

func update_item_description (new_text : String) -> void :
	item_description.text = new_text
	
func _on_load_pressed () -> void :
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

func change_tab( _i : int = 1 ) -> void :
	tab_container.current_tab = wrapi(
		tab_container.current_tab + _i,
		0,
		tab_container.get_tab_count()
	)
	tab_container.get_tab_bar().grab_focus()
	pass
