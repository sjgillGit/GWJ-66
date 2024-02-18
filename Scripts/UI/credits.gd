extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()


func _on_quit_pressed():
	get_tree().quit()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Main/main.tscn")
