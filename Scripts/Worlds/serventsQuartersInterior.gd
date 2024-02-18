extends Node3D


@export var scene_builder:SceneBuilder


func _ready():
	scene_builder.create_player_if_isolated(self)

