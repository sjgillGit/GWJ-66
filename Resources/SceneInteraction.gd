extends Resource
class_name SceneInteraction


signal items_combined(item_name:String)


var combos:Array = [["Bottle", "AcidPool"]]
var current_raycasted_object:Area3D
var dragged_item:String
var is_dragging_item:bool = false : set = set_is_dragging


func set_is_dragging(new_value:bool):
	is_dragging_item = new_value
	if !is_dragging_item:
		drop_item()
	current_raycasted_object = null
	dragged_item = ""


func drop_item():
	if !dragged_item or !current_raycasted_object:
		return
	print(dragged_item)
	print(current_raycasted_object.name)
	for combo in combos:
		if are_combos_equal(combo, [dragged_item, current_raycasted_object.name]):
			items_combined.emit("Bottle")
			current_raycasted_object.queue_free()


func are_combos_equal(left:Array, right:Array) -> bool:
	return left[0] == right[0] and left[1] == right[1]
