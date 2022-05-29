extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("custom_attack"):
		var GrassEffect = load("res://Effects/GrassEffect.tscn")
		var grassEffect = GrassEffect.instance()
		var world = get_tree().get_current_scene()
		grassEffect.global_position = global_position
		world.add_child(grassEffect)
		queue_free()


func _on_HurtBox_area_entered(area):
	pass # Replace with function body.
