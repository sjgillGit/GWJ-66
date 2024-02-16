extends Node3D


@export var scene_builder:SceneBuilder


func _ready():
	connect_objects_signals()
	connect_scene_builder_signals()
	update_objects()


func update_objects():
	scene_builder.set_world_items($Objects, "Yard")


func connect_objects_signals():
	for object in $Objects.get_children():
		object.picked.connect(_on_object_picked)


func connect_scene_builder_signals():
	scene_builder.list_changed.connect(_on_scene_builder_list_changed)


func _on_object_picked(obj_name:String):
	scene_builder.remove_object("Yard", obj_name)


func _on_scene_builder_list_changed():
	update_objects()
