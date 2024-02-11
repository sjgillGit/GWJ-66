extends CharacterBody3D

#--------------------
# Main player class
# Contains data and links to controllers
#---------------------

class_name Player

@onready var movement: MovementController = get_node("MovementController")
