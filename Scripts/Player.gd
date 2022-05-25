extends KinematicBody2D

var velocity = Vector2.ZERO
const MAX_SPEED = 100

func _physics_process(delta):
	# delta = time taken by last frame to process
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if input_vector == Vector2.ZERO:
		velocity = Vector2.ZERO
	else:
		velocity = input_vector
	velocity = velocity * delta * MAX_SPEED
	move_and_collide(velocity)
