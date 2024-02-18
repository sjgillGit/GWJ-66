@tool
extends Area3D


signal picked(obj_name:String)


enum Type {PADLOCK_KEY, HORSESHOE, TOOLBOX, HAMMER, WRENCH, PILLS, GLASS_BOTTLE, MUDDLER, KEY_V2}

@export var dialogue:Dialogue
@export var type:Type : set = set_type
var models:Dictionary = {Type.PADLOCK_KEY:load("res://Assets/Inventory Objects/Key.glb")
, Type.KEY_V2:load("res://Assets/Inventory Objects/ChainKey.glb")}
var object_name:String


func set_type(new_type:Type):
	type = new_type
	NodeTools.delete_all_children($Mesh)
	match type:
		Type.PADLOCK_KEY:
			set_object_name("Padlock key")
			$Mesh.add_child(models[type].instantiate())
		Type.HORSESHOE:
			set_object_name("Horseshoe")
			$Mesh.add_child(models[type].instantiate())
		Type.TOOLBOX:
			set_object_name("Hammer")
			$Mesh.add_child(models[type].instantiate())
		Type.WRENCH:
			set_object_name("Wrench")
			$Mesh.add_child(models[type].instantiate())
		Type.PILLS:
			set_object_name("Pills")
			$Mesh.add_child(models[type].instantiate())
		Type.GLASS_BOTTLE:
			set_object_name("Glass bottle")
			$Mesh.add_child(models[type].instantiate())
		Type.MUDDLER:
			set_object_name("Muddler")
			$Mesh.add_child(models[type].instantiate())
		Type.KEY_V2:
			set_object_name("Key V2")
			$Mesh.add_child(models[type].instantiate())


func _ready():
	self.type = type


func set_object_name(new_name:String):
	name = new_name
	object_name = new_name


func _on_body_entered(body):
	dialogue.make_speak("Player", "I picked up the key!!!")
	picked.emit(object_name)
	get_tree().call_group("InventorySpot", "itemGrabbed", object_name)



