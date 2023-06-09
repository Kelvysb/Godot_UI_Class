extends Control
class_name HUD

@onready var vidas = $HFlowContainer/Vidas

func set_vidas(quantidade : int):
	vidas.text = str(quantidade)
