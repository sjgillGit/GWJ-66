extends Area3D


signal picked(obj_name:String)


@export var dialogue:Dialogue


func _on_body_entered(body):
	dialogue.make_speak("Player", "I picked up the key!!!")
	picked.emit(name)
