extends Node3D


@export var dialogue:Dialogue
var speaker_name:String
var skip_pressed:bool = false


func _ready():
	dialogue.speech_triggered.connect(_on_speech_triggered)


func _input(event):
	if event.is_action_pressed("ui_mouse_left"):
		skip_pressed = true


func _write_speech(text:String):
	skip_pressed = false
	get_tree().paused = true
	$Text.text = ""
	for char in text:
		if !skip_pressed:
			await get_tree().create_timer(0.1).timeout
		$Text.text += char
	skip_pressed = false
	while !skip_pressed:
		await get_tree().create_timer(0.1).timeout
	$Text.text = ""
	dialogue.receive_response()
	get_tree().paused = false
	

func _on_speech_triggered(speaker:String, message:String):
	if speaker == speaker_name:
		_write_speech(message)
