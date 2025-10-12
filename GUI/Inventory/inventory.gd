extends CanvasLayer

#region /// Variables
var inventory_show : bool = false
#endregion

#region /// On Ready Variables
@onready var inventory_slot: Button = $Control/ColorRect/Panel/GridContainer/InventorySlot
@onready var item_description: Label = $Control/ItemDescription
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

#func play_audio( audio : AudioStream) -> void :
	#audio_stream_player.stream = audio
	#audio_stream_player.play()
	#pass
