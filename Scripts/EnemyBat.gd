extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var knockBack = Vector2.RIGHT
onready var stats = $Stats
onready var playerDetectionZone = $PlayerDetectionZone
onready var softCollision = $SoftCollision
onready var wandererManager = $WandereManagerNode

var BatEnemyDeathEffect = preload("res://Effects/BatEnemyDeathEffect.tscn")
var EnemyHitEffect = preload("res://Effects/EnemyHitEffect.tscn")

export var ACCELERATION = 300
export var FRICTION = 300
export var MAX_SPEED = 50

enum {
	IDLE,
	CHASE,
	WANDER
}

var enemyState = IDLE
var velocity = Vector2.ZERO
var wanderDirectionFlag = 0

func _ready():
	animatedSprite.playing = true

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO, 200*delta)
	knockBack = move_and_slide(knockBack)
	
	match enemyState:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
			seek_player_inside_detection_zone()
		CHASE:
			chase_player(delta)
		WANDER:
			var direction_vector = wandererManager.get_direction_to_return_to()
			var has_direction_reversed = wanderDirectionFlag + (direction_vector.x / abs(direction_vector.x))
			
			if has_direction_reversed == 0.0:
				enemyState = IDLE
				wanderDirectionFlag = 0
			else:
				velocity = velocity.move_toward(direction_vector * MAX_SPEED / 2, ACCELERATION * delta)
				animatedSprite.flip_h = direction_vector.x < 0
				wanderDirectionFlag = direction_vector.x / abs(direction_vector.x)
			seek_player_inside_detection_zone()

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400
	velocity = move_and_slide(velocity)

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	create_hit_effect()
	knockBack = area.knockBackVector * 120


func _on_Stats_no_health():
	var batEnemyDeathEffect = BatEnemyDeathEffect.instance()
	batEnemyDeathEffect.global_position = global_position
	get_parent().add_child(batEnemyDeathEffect)
	queue_free()

func create_hit_effect():
	var enemyHitEffect = EnemyHitEffect.instance()
	enemyHitEffect.global_position = global_position
	get_tree().current_scene.add_child(enemyHitEffect)

func chase_player(delta):
	var player = playerDetectionZone.player
	if player != null:
		var enemyMoveDirection = (player.global_position - global_position).normalized()
		velocity = velocity.move_toward(enemyMoveDirection * MAX_SPEED, ACCELERATION * delta)
		animatedSprite.flip_h = enemyMoveDirection.x < 0
	else:
		enemyState = WANDER
		


func seek_player_inside_detection_zone():
	if playerDetectionZone.player != null:
		enemyState = CHASE
		wanderDirectionFlag = 0
	
