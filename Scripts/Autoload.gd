extends Node

var pawn: PackedScene = preload("res://Scenes/Pawn.tscn")

var timer = 10
var happiness = 100


func _process(delta: float) -> void:
	happiness -= 0.01
	if timer > 0:
		timer -= 1


func random(a: int, b:int):
	randomize()
	if randi() % 2 == 0:
		return a
	else:
		return b

func place_pawn(position: Vector2):
		if happiness > 0:
			print('Pawn Spawned')	
			var pawn_instance = pawn.instance()
			pawn_instance.position = position
			$".".add_child(pawn_instance)
