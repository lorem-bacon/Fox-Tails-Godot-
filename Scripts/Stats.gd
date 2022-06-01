extends Node2D

export(int) var max_health = 4
onready var health = max_health setget set_health


func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")

signal no_health

