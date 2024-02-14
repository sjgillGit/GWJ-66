extends Node3D


signal picked(obj_name:String)


func _on_area_body_entered(body):
	picked.emit(name)
