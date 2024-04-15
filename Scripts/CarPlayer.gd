extends CharacterBody2D

#Asfalto
var wheel_base = 70
var steering_angle = 12
var engine_power = 1300
var friction = -0.54
var drag = -0.06
var braking = -770
var max_speed_reverse = 250
var slip_speed = 570
var traction_fast = 4
var traction_slow = 10

var acceleration = Vector2.ZERO
var steer_direction

func _process(delta):
	#print(velocity)
	pass

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction(delta)
	calculate_steering(delta)
	velocity += acceleration * delta
	move_and_slide()
	
func apply_friction(delta):
	if acceleration == Vector2.ZERO and velocity.length() < 50:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction * delta
	var drag_force = velocity * velocity.length() * drag * delta
	acceleration += drag_force + friction_force
	
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
	print("Asfalto")
	
	engine_power = 1300
	friction = -0.54
	drag = -0.06
	braking = -770
	max_speed_reverse = 400
	slip_speed = 570
	traction_fast = 4
	traction_slow = 10
	
func tierra():
	print("Tierra")
	engine_power = 1150
	friction = -0.54
	drag = -0.06
	braking = -770
	max_speed_reverse = 350
	slip_speed = 350
	traction_fast = 2
	traction_slow = 6
	
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
	print("Choque")
	
	
