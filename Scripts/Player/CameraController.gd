extends Camera3D

#--------------------
# Camera contoller
# Tells player where to go by mouse clicking
#---------------------

class_name CameraController

@export var player: Player
var player_movement: MovementController
var is_moving: bool

const RAY_LENGTH = 2000


func _ready():
	player = GlobalScript.player
	assert(player != null, "Please select player in camera")
	#await get_tree().create_timer(0.1).timeout
	player_movement = player.get_node("MovementController")


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_mouse_left"):
		var new_target = get_mouse_world_position()
		if new_target != Vector3.ZERO:
			player_movement.set_target(new_target)


func get_mouse_world_position() -> Vector3:
	var state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(mouse_pos)
	var ray_end = ray_origin + project_ray_normal(mouse_pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	var result = state.intersect_ray(query)
	if result && result.has("position"):
		return result.position
	return Vector3.ZERO
