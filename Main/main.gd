extends Node
class_name Main


@export var player_scene:PackedScene
@export var portals_router:PortalsRouter
@onready var world_scenes:Dictionary = {"Yard":load("res://Scenes/Worlds/Yard.tscn")
, "Farmstead":load("res://Scenes/Worlds/Farmstead/Farmstead.tscn")}
static var portal_timer:Timer
var current_world:Node3D
var current_player:CharacterBody3D
var is_first_world:bool = true

# game began
func _ready():
	portal_timer = $PortalTimer
	connect_portals_router_signals()
	change_world(world_scenes["Yard"], "")


func connect_portals_router_signals():
	portals_router.portal_entered.connect(_on_portal_entered)


func _connect_world_signals():
	pass


func create_world(new_world:PackedScene, arrive_portal_name:String):
	current_world = new_world.instantiate()
	create_new_player()
	if current_player:
		setup_arrived_player()
	if is_first_world:
		setup_first_world()
		is_first_world = false
	$World.add_child(current_world)
	current_world.add_child(current_player)
	if current_player and arrive_portal_name != "":
		set_player_position(get_portal_position(arrive_portal_name))


func setup_first_world():
	current_world.get_node("CameraController").player = current_player
	current_player.position = Vector3(-12, 1, 0)


func change_world(new_world:PackedScene, arrive_portal_name:String=""):
	NodeTools.delete_all_children($World)
	create_world(new_world, arrive_portal_name)


func setup_arrived_player():
	current_world.get_node("CameraController").player = current_player


func set_player_position(new_pos:Vector3):
	current_player.position = new_pos


func get_portal_position(portal_name:String) -> Vector3:
	for obj in current_world.get_node("Objects").get_children():
		if obj.name == portal_name:
			return obj.position
	return Vector3.ZERO


func create_new_player():
	if current_player:
		current_player.queue_free()
	current_player = player_scene.instantiate()


func _on_portal_entered(enterence:String, destination:String):
	change_world(world_scenes[destination], enterence)
	

func _on_portal_timer_timeout():
	portals_router.can_use_portal = true
