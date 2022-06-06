extends Node2D

export(int) var max_health = 4
onready var health = max_health setget set_health


func set_health(value):
	health = value
	print('health atm is ', health)
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

signal no_health
signal health_changed(value)


