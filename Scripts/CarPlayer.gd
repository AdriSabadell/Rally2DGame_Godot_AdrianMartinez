extends CharacterBody2D

#Asfalto
var wheel_base = 70
var steering_angle = 12
var engine_power = 1400
var friction = -0.54
var drag = -0.06
var braking = -770
var max_speed_reverse = 250
var slip_speed = 570
var traction_fast = 4
var traction_slow = 10

var acceleration = Vector2.ZERO
var steer_direction

var vuelta = false 

var damage_level = 0

@onready var time_text : Label = get_node("CanvasLayer/Tiempo Etapa")
@onready var daños_verde : Sprite2D = get_node("CanvasLayer/Mecanico")
@onready var daños_naranja : Sprite2D = get_node("CanvasLayer/Mecanico2")
@onready var daños_rojo : Sprite2D = get_node("CanvasLayer/Mecanico3")

func _process(delta):
	#print(velocity.length())
	#print(damage_level)
	if vuelta == true:
		vuelta_rapida()
	#tiempo_vuelta_actual += get_process_delta_time()
	#print(Global.tiempo_actual)
	time_text.text = "%.2f" % Global.tiempo_actual
	pass

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	if Global.salida_correcta == true:
		empiezaEtapa()
	
func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	if velocity.length() > 300:
		pass
func get_input():
	var turn = Input.get_axis("steer_left", "steer_right")
	steer_direction = turn * deg_to_rad(steering_angle)
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_direction) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = lerp(velocity, new_heading * velocity.length(), traction * delta)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
#	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()

func asfalto():
	if damage_level == 0:
		print("Asfalto")
		engine_power = 1400
		friction = -0.54
		drag = -0.06
		braking = -770
		max_speed_reverse = 400
		slip_speed = 570
		traction_fast = 5
		traction_slow = 10

	if damage_level == 1:
		print("Asfalto")
		engine_power = 1000
		friction = -0.54
		drag = -0.06
		braking = -650
		max_speed_reverse = 350
		slip_speed = 400
		traction_fast = 3
		traction_slow = 7
		
	if damage_level > 1:
		print("Asfalto")
		engine_power = 600
		friction = -0.54
		drag = -0.06
		braking = -500
		max_speed_reverse = 300
		slip_speed = 300
		traction_fast = 1
		traction_slow = 5
	
func tierra():
	if damage_level == 0:
		print("Tierra")
		engine_power = 1200
		friction = -0.50
		drag = -0.06
		braking = -600
		max_speed_reverse = 250
		slip_speed = 400
		traction_fast = 1
		traction_slow = 4
		
	if damage_level == 1:
		print("Tierra")
		engine_power = 900
		friction = -0.50
		drag = -0.06
		braking = -500
		max_speed_reverse = 250
		slip_speed = 300
		traction_fast = 1
		traction_slow = 3
		
	if damage_level == 2:
		print("Tierra")
		engine_power = 800
		friction = -0.50
		drag = -0.06
		braking = -400
		max_speed_reverse = 250
		slip_speed = 150
		traction_fast = 2
		traction_slow = 5
func hierba():
		print("Hierba")
		engine_power = 300
		friction = -0.54
		drag = -0.06
		braking = -770
		max_speed_reverse = 250
		slip_speed = 200
		traction_fast = 1
		traction_slow = 4
	 
func choque():
	#print("Choque")
	print(velocity.length())
	if velocity.length() > 500:
		damage_level = damage_level + 1
	if damage_level == 1:
		daños_naranja.visible = true
	if damage_level == 2:
		daños_rojo.visible = true


func empiezaEtapa():
	vuelta = true
	
func vuelta_rapida():
	Global.tiempo_actual += get_process_delta_time()
	
func finalEtapa1():
	vuelta = false 
	Global.salida_correcta = false
	get_tree().change_scene_to_file("res://Scenes/Rally1/Stage2/stage_2.tscn")
func finalEtapa2():
	vuelta = false 
	get_tree().change_scene_to_file("res://Scenes/Rally1/Stage3/stage_3.tscn")
func finalEtapa3():
	vuelta = false 
	get_tree().change_scene_to_file("res://Scenes/Marcador/menu_marcador.tscn")
func penalizacion():
	Global.tiempo_actual += 5


