extends Node2D

onready var initialPosition = global_position

func get_direction_to_return_to():
	var currentPosition = global_position
	return currentPosition.direction_to(initialPosition).normalized()
