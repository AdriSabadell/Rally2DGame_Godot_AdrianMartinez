extends Area2D

var empieza_cuenta = true
var tiempo_salida = 0
var jugador_componente

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if empieza_cuenta == true:
		tiempo_salida += get_process_delta_time()
	#print(tiempo_salida)
	if tiempo_salida > 2:
		$RedLight.visible = true
	if tiempo_salida > 4:
		empieza_cuenta = false
		$RedLight.visible = false
func _on_body_entered(body):
	if body.is_in_group("Player") and tiempo_salida < 4:
		body.penalizacion()
		body.empiezaEtapa()
	if body.is_in_group("Player") and tiempo_salida > 4:
		body.empiezaEtapa()
