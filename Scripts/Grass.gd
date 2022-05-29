extends Node2D

func create_grass_destroy_effect():
	var GrassEffect = load("res://Effects/GrassEffect.tscn")
	var grassEffect = GrassEffect.instance()
	var world = get_tree().get_current_scene()
	grassEffect.global_position = global_position
	world.add_child(grassEffect)



func _on_HurtBox_area_entered(area):
	create_grass_destroy_effect()
	queue_free()
