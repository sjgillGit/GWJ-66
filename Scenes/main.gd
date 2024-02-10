extends Node


@export var player_scene:PackedScene
@export var world_scenes:Array[PackedScene]
var current_world:Node3D

# game began
func _ready():
	change_world(world_scenes[0])
	_connect_world_signals()
	setup_world([])


func _connect_world_signals():
	pass


func create_world(new_world:PackedScene):
	current_world = new_world.instantiate()
	$World.add_child(current_world)


func setup_world(world_objects:Array):
	current_world.populate_world(world_objects)


func change_world(new_world:PackedScene):
	NodeTools.delete_all_children($World)
	create_world(new_world)
	
