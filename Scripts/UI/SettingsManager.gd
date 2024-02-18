extends Control


@onready var speechVolume = $Options/SpeechVolume
@onready var musicvolume = $Options/MusicVolume
@onready var soundVolume = $Options/SoundVolume

@onready var speechBusID = AudioServer.get_bus_index("Speech")
@onready var musicBusID = AudioServer.get_bus_index("Music")
@onready var soundBusID = AudioServer.get_bus_index("Sound")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if !GlobalScript.gamePaused:
			show()
			GlobalScript.gamePaused = true
			get_tree().paused = true
		else:
			hide()
			GlobalScript.gamePaused = false
			get_tree().paused = false


func _on_resume_game_pressed():
	setSettings()
	hide()
	GlobalScript.gamePaused = false
	get_tree().paused = false


func _on_quit_game_pressed():
	get_tree().quit()

func setSettings():
	AudioServer.set_bus_volume_db(speechBusID, linear_to_db(speechVolume.value))
	AudioServer.set_bus_mute(speechBusID, speechVolume.value < 0.05)
	
	AudioServer.set_bus_volume_db(musicBusID, linear_to_db(musicvolume.value))
	AudioServer.set_bus_mute(musicBusID, musicvolume.value < 0.05)
	
	AudioServer.set_bus_volume_db(soundBusID, linear_to_db(soundVolume.value))
	AudioServer.set_bus_mute(soundBusID, soundVolume.value < 0.05)
	
	
