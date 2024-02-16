extends Area3D

@export var tag = ""

signal picked(obj_name:String)


@export var dialogue:Dialogue


func _on_body_entered(body):
	dialogue.make_speak("Player", "I picked up the key!!!")
	picked.emit(name)
	get_tree().call_group("InventorySpot", "itemGrabbed", tag)
