extends Node2D

@onready var time_text : Label = get_node("TiempoJugador")
@onready var primeraPosicion : Sprite2D = get_node("Primero")
@onready var segundaPosicion : Sprite2D = get_node("Segundo")
@onready var terceraPosicion : Sprite2D = get_node("Tercero")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_text.text = "%.2f" % Global.tiempo_actual
	if Global.tiempo_actual < 108.64:
		primeraPosicion.visible = true
	if Global.tiempo_actual < 112.39:
		segundaPosicion.visible = true
	if Global.tiempo_actual < 118.84:
		terceraPosicion.visible = true
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/Marcador/MenuPrincipal.tscn")
