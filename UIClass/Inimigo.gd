extends RigidBody3D
class_name Inimigo

@export var dano = 1
@onready var Player : CharacterBody3D

func AddPlayer(player : CharacterBody3D):
	Player = player

func _physics_process(delta):
	if Player:
		var player_pos =  Player.position
		linear_velocity = (player_pos - global_transform.origin) * 1.0
