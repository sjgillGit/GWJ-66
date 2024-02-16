extends Node3D

@export var tag = ""

signal picked(obj_name:String)


func _on_area_body_entered(body):
	picked.emit(name)
	get_tree().call_group("InventorySpot", "itemGrabbed", tag)
