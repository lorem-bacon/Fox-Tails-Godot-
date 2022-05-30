extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 80
const ROLL_SPEED = 120
const FRICTION = 500
const ACCELERATION = 500

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
onready var swordHitbox = $Position2D/Hitbox

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

func _ready():
	animationTree.active = true
	$Position2D/Hitbox/CollisionShape2D.disabled = true
	swordHitbox.knockBackVector = Vector2.ZERO


func _physics_process(delta):
	# delta = time taken by last frame to process
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state()
		ATTACK:
			attack_state()

func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()

	swordHitbox.knockBackVector = input_vector
	if input_vector == Vector2.ZERO:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#		direction_to Gives jittery effect
#		velocity = velocity.direction_to(Vector2.ZERO)* FRICTION * delta
		animationState.travel("Idle")
	else:
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Run/blend_position", input_vector)
		animationTree.set("parameters/Attack/blend_position", input_vector)
		animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Run")
		
		if Input.is_action_just_pressed("custom_roll"):
			velocity = input_vector * ROLL_SPEED
			state = ROLL
#	move_and_collide(velocity * delta)
	velocity = move_and_slide(velocity)
	
	if Input.is_action_just_pressed("custom_attack"):
		state = ATTACK

func attack_state():
	velocity = Vector2.ZERO
	animationState.travel("Attack")

func roll_state():
	animationState.travel("Roll")
	velocity = move_and_slide(velocity)

func attack_animation_finished():
	state = MOVE

func roll_animation_finished():
	velocity = velocity * 0.7
	state = MOVE
