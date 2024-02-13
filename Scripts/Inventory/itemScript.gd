extends Node

## Just the name of the item, also put same tag in an inventory space.
@export var tag = ""

func pickedUp():
	get_tree().call_group("QuickInventorySpot", "itemGrabbed", tag)
	queue_free()
