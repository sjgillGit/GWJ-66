extends Resource
class_name SceneBuilder


signal list_changed


var worlds_objects:Dictionary = {"Yard":["Key"]}


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
