@tool
extends Area3D


signal picked(obj_name:String)


enum Type {PADLOCK_KEY, HORSESHOE, TOOLBOX, HAMMER, WRENCH, PILLS, GLASS_BOTTLE, MUDDLER, KEY_V2}

@export var dialogue:Dialogue
@export var type:Type : set = set_type
var models:Dictionary = {Type.PADLOCK_KEY:load("res://Assets/Inventory Objects/Key.glb")
, Type.HORSESHOE:load("res://Assets/Inventory Objects/horseshoe.glb")
, Type.TOOLBOX:load("res://Assets/Inventory Objects/Toolbox.glb")
, Type.HAMMER:load("res://Assets/Inventory Objects/Hammer.glb")
, Type.WRENCH:load("res://Assets/Inventory Objects/wrench.glb")
, Type.PILLS:load("res://Assets/Inventory Objects/Chemical Solution/PillBottle.glb")
, Type.GLASS_BOTTLE:load("res://Assets/Inventory Objects/Chemical Solution/EmptyBottle.glb")
, Type.MUDDLER:load("res://Assets/Inventory Objects/Chemical Solution/Muddler.glb")
, Type.KEY_V2:load("res://Assets/Inventory Objects/ChainKey.glb")

}

var object_name:String


func set_type(new_type:Type):
	type = new_type
	NodeTools.delete_all_children($Mesh)
	match type:
		Type.PADLOCK_KEY:
			set_object_name("Key")
			$Mesh.add_child(models[type].instantiate())
		Type.HORSESHOE:
			set_object_name("Horse Shoe")
			$Mesh.add_child(models[type].instantiate())
		Type.TOOLBOX:
			set_object_name("Tool Box")
			$Mesh.add_child(models[type].instantiate())
		Type.WRENCH:
			set_object_name("Wrench")
			$Mesh.add_child(models[type].instantiate())
		Type.PILLS:
			set_object_name("Pill Bottle")
			$Mesh.add_child(models[type].instantiate())
		Type.GLASS_BOTTLE:
			set_object_name("Bottle")
			$Mesh.add_child(models[type].instantiate())
		Type.MUDDLER:
			set_object_name("Muddler")
			$Mesh.add_child(models[type].instantiate())
		Type.KEY_V2:
			set_object_name("Chain Key")
			$Mesh.add_child(models[type].instantiate())
		Type.HAMMER:
			set_object_name("Hammer")
			$Mesh.add_child(models[type].instantiate())


func _ready():
	self.type = type


func set_object_name(new_name:String):
	name = new_name
	object_name = new_name


func _on_body_entered(body):
	if body.name != "Player":
    return
	if type == Type.GLASS_BOTTLE:
		dialogue.make_speak(
			"Player", "I found this empty little glass bottle, maybe I can put something in it…")
	picked.emit(object_name)
	get_tree().call_group("InventorySpot", "itemGrabbed", object_name)
	GlobalScript.playerPickingUp = true


