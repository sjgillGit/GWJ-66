extends Node3D

#--------------------
# Player movement controller
#---------------------

class_name MovementController

@export var speed = 10
var accel = 5

@onready var nav_agent: NavigationAgent3D = get_node("../NavAgent")
@onready var player: Player = get_parent()

var has_target: bool


func set_target(new_target: Vector3) -> void:
	nav_agent.target_position = new_target
	has_target = true


func _physics_process(delta: float) -> void:
	if !has_target: return
	
	if nav_agent.is_navigation_finished(): 
		has_target = false
		return
	
	var dir = Vector3()
	dir = nav_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	
	player.velocity = player.velocity.lerp(dir * speed, accel * delta)
	player.move_and_slide()
