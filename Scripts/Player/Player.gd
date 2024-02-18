extends CharacterBody3D

#--------------------
# Main player class
# Contains data and links to controllers
#---------------------

class_name Player

@export var dialogue: Dialogue
@onready var movement: MovementController = get_node("MovementController")

@onready var tree = $Mesh/Protagonist/AnimationTree

func _ready():
	$Speech.speaker_name = name
	
func _process(delta):
	tree.set("parameters/conditions/Walking", GlobalScript.playerWalking)
	tree.set("parameters/conditions/Idle", GlobalScript.playerIdle)
