extends Node3D
class_name Cura

@onready var valor = 1

func _physics_process(delta):
	var camera_position = get_viewport().get_camera_3d().global_position
	look_at(camera_position)
