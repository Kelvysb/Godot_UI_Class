extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@export var MOUSE_SENSITIVITY = 0.05
@export var TURN_SPEED = 10
@export var vidas = 10
@export var hpMax = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var pivot = $CameraMount
@onready var camera = $CameraMount/Camera3D
@onready var geometry = $Geometry
@onready var menu_pausa = $MenuPausa
@onready var hud = $HUD

func _ready():
	hud.hpMax = hpMax;

func _input(event):
	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif Input.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true
		menu_pausa.visible = true
		await get_tree().create_timer(0.1).timeout
		
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg_to_rad(-(event as InputEventMouseMotion).relative.x * MOUSE_SENSITIVITY))
		geometry.rotate_y(deg_to_rad((event as InputEventMouseMotion).relative.x * MOUSE_SENSITIVITY))
		pivot.rotate_x(deg_to_rad(-(event as InputEventMouseMotion).relative.y * MOUSE_SENSITIVITY))
		pivot.rotation.x = deg_to_rad(clamp(rad_to_deg(pivot.rotation.x), -90, 90))

func _physics_process(delta):
	
	hud.set_vidas(vidas)
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED	
		var prev_y = geometry.rotation.y
		geometry.look_at(position + direction)
		var target_y = geometry.rotation.y
		geometry.rotation.y = lerp_angle(prev_y, target_y, delta * TURN_SPEED)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if(body.is_in_group("inimigo")):
		vidas = vidas - (body as Inimigo).dano
		if(vidas <= 0):
			game_over()

func game_over():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().change_scene_to_file("res://GameOver.tscn")
