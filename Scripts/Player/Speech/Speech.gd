extends Node3D


@export var dialogue:Dialogue
var speaker_name:String


func _ready():
	dialogue.speech_triggered.connect(_on_speech_triggered)


func _write_speech(text:String):
	$Text.text = ""
	for char in text:
		await get_tree().create_timer(0.1).timeout
		$Text.text += char
	await get_tree().create_timer(0.5).timeout
	$Text.text = ""
	dialogue.receive_response()
	

func _on_speech_triggered(speaker:String, message:String):
	if speaker == speaker_name:
		_write_speech(message)
