extends Node3D


func write_speech(text:String):
	$Text.text = ""
	for char in text:
		await get_tree().create_timer(0.1).timeout
		$Text.text += char
	
