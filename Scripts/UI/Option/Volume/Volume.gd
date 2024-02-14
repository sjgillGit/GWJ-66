extends HBoxContainer


signal add_pressed
signal substract_pressed
signal value_set(new_value:int)


func _on_left_pressed():
	substract_pressed.emit()


func _on_right_pressed():
	add_pressed.emit()


func _on_slider_drag_ended(value_changed):
	value_set.emit(value_changed)
