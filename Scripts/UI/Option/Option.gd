@tool
extends HBoxContainer

@export var value:float = 0 : set = set_value
@export var text:String = "Option" : set = set_text
@export var change_increment:float = 2.0
@export var control_type:PackedScene : set = set_control_type
var current_control:Node


func set_text(new_text:String):
	text = new_text
	$Text.text = text


func set_value(new_value:float):
	value = clamp(new_value, 0, 100)
	if is_volume():
		current_control.get_node("Slider").value = value


func set_control_type(new_control_type:PackedScene):
	control_type = new_control_type
	await ready
	NodeTools.delete_all_children(self, $Text)
	if control_type:
		set_control()


func set_control():
	current_control = control_type.instantiate()
	add_child(current_control)
	move_child(current_control, -1)


func _ready():
	await get_tree().create_timer(0.1).timeout
	set_value(value)
	connect_volume_signals(current_control)


func connect_volume_signals(control:Node):
	if control.has_signal("add_pressed") and !Engine.is_editor_hint():
		control.add_pressed.connect(_on_add_pressed)
		control.substract_pressed.connect(_on_substract_pressed)


func is_volume() -> bool:
	if current_control:
		if current_control.has_node("Slider"):
			return true
	return false


func _on_add_pressed():
	self.value += change_increment


func _on_substract_pressed():
	self.value -= change_increment
