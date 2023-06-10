extends Control
class_name HUD

@onready var vidas = $HFlowContainer/Vidas
@onready var hpMax = 10
@onready var heart = load("res://Heart.png")
@onready var heartlow = load("res://Heart2.png")

func _ready():
	for vida in range(0, hpMax):
		var heart_rect = TextureRect.new()
		heart_rect.texture = heart
		vidas.add_child(heart_rect)

func set_vidas(quantidade : int):
	var element = 0
	for heartelement in vidas.get_children():
		if(element < quantidade):
			(heartelement as TextureRect).texture = heart
		else:
			(heartelement as TextureRect).texture = heartlow
		element += 1
