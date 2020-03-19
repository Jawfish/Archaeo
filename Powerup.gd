extends Node2D

var powerup = 0

func _ready() -> void:
	powerup = floor(rand_range(1,3))
	if powerup == 1:
		scale.x = 0.02
		scale.y = 0.02
		$Sprite.texture = load("res://Assets/Images/clock.svg")
	elif powerup == 2:
		scale.x = 0.02
		scale.y = 0.02
		$Sprite.texture = load("res://Assets/Images/happy.png")
	else:
		scale.x = 0.02
		scale.y = 0.02
		$Sprite.texture = load("res://Assets/Images/happy.png")

