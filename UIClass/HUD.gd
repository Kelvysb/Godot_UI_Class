extends Control
class_name HUD

@onready var vidas = $HFlowContainer/Vidas
@onready var hpMax = 10
@onready var hp_1 = $Hp1

func _ready():
	vidas.max_value = hpMax

func set_vidas(quantidade : int):
	vidas.value = quantidade
	hp_1.size.x = 32 * quantidade
