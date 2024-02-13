@tool
extends HBoxContainer


signal box_toggled_on(index:int)


@export var text:String : set = set_text


func set_text(new_text:String):
	text = new_text
	$Text.text = text


func _on_check_toggled(toggled_on):
	if !toggled_on:
		return
	box_toggled_on.emit(get_index())
	$Check.button_pressed = true
	
