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
	tree.set("parameters/conditions/Walking", GlobalScript.playerWalking && !GlobalScript.holdingDirtyKey)
	tree.set("parameters/conditions/Idle", GlobalScript.playerIdle && !GlobalScript.holdingDirtyKey && !GlobalScript.playerSleeping)
	tree.set("parameters/conditions/Pickup", GlobalScript.playerPickingUp)
	tree.set("parameters/conditions/PickupDown", false)
	tree.set("parameters/conditions/KeyIdle", GlobalScript.playerIdle && GlobalScript.holdingDirtyKey)
	tree.set("parameters/conditions/KeyWalk", GlobalScript.playerWalking && GlobalScript.holdingDirtyKey)
	tree.set("parameters/conditions/Knife", GlobalScript.playerUsingKnife)
	tree.set("parameters/conditions/Sleep", GlobalScript.playerSleeping)
	
	if GlobalScript.playerPickingUp:
		GlobalScript.playerPickingUp = false
	if GlobalScript.playerUsingKnife:
		GlobalScript.playerUsingKnife = true
		
		
