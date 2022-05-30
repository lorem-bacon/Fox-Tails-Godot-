extends KinematicBody2D

onready var animatedSprite = $AnimatedSprite
onready var knockBack = Vector2.RIGHT
onready var stats = $Stats

func _ready():
	animatedSprite.playing = true

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO, 200*delta)
	knockBack = move_and_slide(knockBack)
	
func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockBack = area.knockBackVector * 120
#	queue_free()


func _on_Stats_no_health():
	queue_free()
