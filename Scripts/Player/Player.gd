extends CharacterBody3D

#--------------------
# Main player class
# Contains data and links to controllers
#---------------------

class_name Player

@export var dialogue: Dialogue
@onready var movement: MovementController = get_node("MovementController")


func _ready():
	$Speech.speaker_name = name
