extends Control

var hearts = 1 setget set_hearts
var max_hearts = 1 setget set_max_hearts

onready var label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if label != null:
		label.text = "HP = " + str(hearts)
	print(label.text)
	

func set_max_hearts(value):
	max_hearts = max(value, 1)

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.max_health
	PlayerStats.connect("health_changed", self, "set_hearts")
#	PlayerStats.connect("no_health", self, "set_hearts")


