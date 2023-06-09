extends Control

func _input(event):
	if(Input.is_action_just_pressed("ui_cancel")):
		await get_tree().create_timer(0.1).timeout
		_on_continue_pressed()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	


func _on_salir_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://MenuInicial.tscn")
