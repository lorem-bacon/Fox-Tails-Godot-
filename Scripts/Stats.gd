extends Node2D

export(int) var max_health = 4 setget set_max_health
onready var health = max_health setget set_health


func set_health(value):
	health = value
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health")

func set_max_health(value):
	max_health = value

signal no_health
signal health_changed(value)


