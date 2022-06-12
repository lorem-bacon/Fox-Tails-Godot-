extends Button

onready var button_icon = $Button

func _ready():
	print('ready')
	button_icon.frame = 0

func _input(event):
	if event.is_action_pressed("ui_accept"):
		emit_signal("button_down")
	if event.is_action_released("ui_accept"):
		emit_signal("button_up")

func _on_PlayButton_button_down():
	button_icon.frame = 1


func _on_PlayButton_button_up():
	button_icon.frame = 0
	get_tree().change_scene("res://Scenes/World.tscn")
	
