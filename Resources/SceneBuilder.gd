extends Resource
class_name SceneBuilder


signal list_changed


@export var player_scene:PackedScene = load("res://Scenes/Player/Player.tscn")
var worlds_objects:Dictionary = {"Yard":["Bottle", "Farmstead", "AcidPool"], "Farmstead":[], "Stables":[]}


func set_world_items(objects_node:Node, scene_name:String):
	for object in objects_node.get_children():
		object.visible = object.name in worlds_objects[scene_name]
		if object is Area3D:
			object.set_deferred("monitoring", object.name in worlds_objects[scene_name])
			object.set_deferred("monitorable", object.name in worlds_objects[scene_name])


func remove_object(scene_name:String, object_name:String):
	worlds_objects[scene_name].erase(object_name)
	list_changed.emit()


func add_object(scene_name:String, object_name:String):
	worlds_objects[scene_name].append(object_name)
	list_changed.emit()


func create_player_if_isolated(world:Node3D):
	if !is_isolated_scene(world):
		return
	var player = player_scene.instantiate()
	world.get_node("CameraController").player = player
	world.add_child(player)
	player.position = world.get_node("IsolatedPlayerPosition").position


func is_isolated_scene(world:Node) -> bool:
	return world.get_parent() is Window
