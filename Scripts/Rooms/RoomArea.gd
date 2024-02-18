extends Area3D

#--------------------
# Trigger to entering room area
# When player comes in, moves camera to new pos
#---------------------

class_name RoomArea

@export var room_camera_pos_node: Node3D

var camera_pos: Vector3
var main_camera: CameraController

const CLOSE_DISTANCE = 0.5
const CAMERA_SPEED = 5

signal player_enter


func _ready():
	
	set_process(false)
	assert(room_camera_pos_node != null, "Set Room Camera Pos Node")
	camera_pos = room_camera_pos_node.global_position
	main_camera = $"../../../CameraController"#get_tree().root.get_camera_3d()
	assert(main_camera is CameraController, "Set CameraController script to main camera")


func _on_body_entered(body: Node3D) -> void:
	if !body is Player: return
	if main_camera.is_moving: return
	set_process(true)


func _process(delta: float) -> void:
	if main_camera.global_position.distance_to(camera_pos) < CLOSE_DISTANCE:
		main_camera.is_moving = false
		set_process(false)
		return
	
	main_camera.is_moving = true
	main_camera.global_position = main_camera\
		.global_position.lerp(camera_pos, CAMERA_SPEED * delta)
