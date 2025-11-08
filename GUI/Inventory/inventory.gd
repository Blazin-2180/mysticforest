extends CanvasLayer

#region /// Variables
var inventory_show : bool = false
#endregion

#region /// On Ready Variables
@onready var inventory_slot: Button = $Control/TabContainer/Inventory/Panel/GridContainer/InventorySlot
@onready var item_description: Label = $Control/TabContainer/Inventory/ItemDescription	
@onready var button_load: Button = $Control/TabContainer/System/VBoxContainer/Button_Load
@onready var tab_container: TabContainer = $Control/TabContainer
@onready var audio_stream : AudioStreamPlayer = $AudioStreamPlayer
#endregion

#region /// Signals
signal shown
signal hidden
signal preview_stats_changed ( item : ItemData )
#endregion

func _ready() -> void:
	hide_inventory()
	pass

func _unhandled_input ( event : InputEvent ) -> void:
	if event.is_action_pressed( "inventory" ) || event.is_action_pressed( "ui_cancel" ):
		if inventory_show == false :
			if DialogSystem.is_active:
				return
			show_inventory()
		else : 
			hide_inventory()
			get_viewport().set_input_as_handled()

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


func focus_item_changed( slot : SlotData ) -> void : 
	if slot : 
		if slot.item_data :
			update_item_description( slot.item_data.description )
			preview_stats( slot.item_data )
	else : 
		update_item_description("")
		preview_stats( null )
	pass


func _on_load_pressed () -> void :
	GlobalSaveManager.load_game()
	await GlobalLevelManager.level_load_started
	hide_pause_menu()
	pass


func hide_pause_menu () -> void : 
	visible = false


func _on_button_exit_pressed() -> void:
	get_tree().quit()


func play_audio( audio : AudioStream ) -> void :
	audio_stream.stream = audio
	audio_stream.play()
	pass


func change_tab( _i : int = 1 ) -> void :
	tab_container.current_tab = wrapi(
		tab_container.current_tab + _i,
		0,
		tab_container.get_tab_count()
	)
	tab_container.get_tab_bar().grab_focus()
	pass


func preview_stats( item : ItemData) -> void : 
	preview_stats_changed.emit( item )
	pass


func _on_button_pressed() -> void:
	Inventory.hide()
	pass # Replace with function body.
