extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	show()
	GlobalScript.gamePaused = true
	get_tree().paused = true


func _on_play_pressed():
	hide()
	GlobalScript.gamePaused = false
	get_tree().paused = false


func _on_how_to_play_pressed():
	pass # Replace with function body.


func _on_quit_pressed():
	get_tree().quit()
