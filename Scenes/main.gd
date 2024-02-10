extends Node


@export var player_scene:PackedScene
@export var world_scene:PackedScene
var current_world:Node3D

# game began
func _ready():
	create_world()
	_connect_world_signals()
	setup_world([])


func _connect_world_signals():
	pass


func create_world():
	current_world = world_scene.instantiate()
	$World.add_child(current_world)


func setup_world(world_objects:Array):
	current_world.populate_world(world_objects)
