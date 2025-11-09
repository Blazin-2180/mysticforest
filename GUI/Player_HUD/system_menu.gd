extends CanvasLayer

signal shown
signal hidden

@onready var button_load: Button = $System/VBoxContainer/Button_Load
@onready var button_exit: Button = $System/VBoxContainer/Button_Exit

var system_menu_show : bool = false


func _ready() -> void:
	hide_system_menu()
	pass

func _unhandled_input ( event : InputEvent ) -> void:
	if event.is_action_pressed( "system_menu" ):
		if system_menu_show == false :
			if DialogSystem.is_active:
				return
			show_system_menu()
		else : 
			hide_system_menu()
			get_viewport().set_input_as_handled()


func show_system_menu () -> void :
	visible = true
	system_menu_show = true
	shown.emit()


func hide_system_menu () -> void : 
	visible = false
	hidden.emit()


func _on_button_load_pressed() -> void:
	GlobalSaveManager.load_game()
	await GlobalLevelManager.level_load_started
	hide_system_menu()
	pass # Replace with function body.


func _on_button_exit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


func _on_button_pressed() -> void:
	SystemMenu.hide_system_menu()
	pass # Replace with function body.
