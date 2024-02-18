extends Camera3D

#--------------------
# Camera contoller
# Tells player where to go by mouse clicking
#---------------------

class_name CameraController

@export var player: Player : set = set_player
@export var scene_interaction:SceneInteraction
var player_movement: MovementController
var is_moving: bool

const RAY_LENGTH = 2000


func set_player(new_player:Player):
	player = new_player
	if player:
		player_movement = player.get_node("MovementController")
    
func _ready():
	player = GlobalScript.player
	assert(player != null, "Please select player in camera")
	#await get_tree().create_timer(0.1).timeout
	player_movement = player.get_node("MovementController")


func _process(_delta) -> void:
	if !player_movement:
		return
	if Input.is_action_just_pressed("ui_mouse_left"):
		var new_target = get_mouse_world_position()
		if new_target != Vector3.ZERO:
			player_movement.set_target(new_target)
	get_mouse_world_position(true)


func get_mouse_world_position(is_interaction:bool=false) -> Vector3:
	var state = get_world_3d().direct_space_state
	var mouse_pos = get_viewport().get_mouse_position()
	var ray_origin = project_ray_origin(mouse_pos)
	var ray_end = ray_origin + project_ray_normal(mouse_pos) * RAY_LENGTH
	var query = PhysicsRayQueryParameters3D.create(ray_origin, ray_end)
	query.collide_with_areas = is_interaction
	var result = state.intersect_ray(query)
	if result && result.has("position"):
		return result.position
	if result.has("collider"):
		if result.collider is Area3D and is_interaction:
			scene_interaction.current_raycasted_object = result.collider
			print(result.collider)
	return Vector3.ZERO
