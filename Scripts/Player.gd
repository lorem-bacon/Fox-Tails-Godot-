extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 80
const FRICTION = 500
const ACCELERATION = 500

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	# delta = time taken by last frame to process
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	if input_vector == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#		direction_to Gives jittery effect
#		velocity = velocity.direction_to(Vector2.ZERO)* FRICTION * delta
		animationPlayer.play("IdleDown")
	else:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationPlayer.play("RunRight")
	move_and_collide(velocity * delta)


#export (int) var speed = 200
#
#var target = Vector2()
#var velocity = Vector2()
#
#func _input(event):
#	if event.is_action_pressed("click"):
#		target = get_global_mouse_position()
#		print(target)
#
#func _physics_process(delta):
#	velocity = position.direction_to(target) * speed
#	# look_at(target)
#	if position.distance_to(target) > 5:
#		velocity = move_and_slide(velocity)
