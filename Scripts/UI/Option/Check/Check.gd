extends HBoxContainer


func _ready():
	choose_first()
	connect_boxes_signals()


func choose_first():
	$Box.get_node("Check").button_pressed = true


func connect_boxes_signals():
	for box in get_children():
		if box is BoxContainer:
			box.box_toggled_on.connect(_on_box_toggled_on)


func _on_box_toggled_on(index:int):
	uncheck_other_boxes(index)


func uncheck_other_boxes(checked_box_index:int):
	for child in get_children():
		if child is BoxContainer:
			if child.get_index() != checked_box_index:
				child.get_node("Check").button_pressed = false
