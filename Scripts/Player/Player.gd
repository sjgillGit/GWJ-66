extends CharacterBody3D

#--------------------
# Main player class
# Contains data and links to controllers
#---------------------

class_name Player

@onready var movement: MovementController = get_node("MovementController")


func _ready():
	$Speech.write_speech("This is a new dialogue ability, that will allow for entities to speak out")
