extends Area2D

var player = null

func _on_PlayerDetectionZone_body_entered(body):
	player = body
	print('detection are entered')


func _on_PlayerDetectionZone_body_exited(body):
	player = null
	print('detection are exited')
