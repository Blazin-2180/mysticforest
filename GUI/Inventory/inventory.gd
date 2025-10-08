extends CanvasLayer

var inventory_show : bool = false

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
	print("show")

func hide_inventory () -> void : 
	visible = false
	inventory_show = false
	print("hide")
