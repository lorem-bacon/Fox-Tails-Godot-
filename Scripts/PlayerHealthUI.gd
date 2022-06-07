extends Control

var hearts = 1 setget set_hearts
var max_hearts = 1 setget set_max_hearts

onready var heartsUi = $HealthFullUI
onready var maxheartsUi = $HealthNullUI

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)
	if heartsUi != null:
		heartsUi.rect_size.x = hearts * 15

func set_max_hearts(value):
	max_hearts = max(value, 1)
	if maxheartsUi != null:
		maxheartsUi.rect_size.x = max_hearts * 15

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.max_health
	PlayerStats.connect("health_changed", self, "set_hearts")

