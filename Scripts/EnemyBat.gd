extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var knockBack = Vector2.RIGHT

func _ready():
	animatedSprite.playing = true

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO, 100*delta)
	knockBack = move_and_slide(knockBack)
	
func _on_HurtBox_area_entered(area):
	knockBack = area.knockBackVector * 150
#	queue_free()
