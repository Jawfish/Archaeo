extends Node

var pawn: PackedScene = preload("res://Scenes/Pawn.tscn")
var world: PackedScene = preload("res://Scenes/World.tscn")

var timer = 10
var happiness = 100
var colorblind: bool = false
var camera_shake: bool = true


func _process(delta: float) -> void:
	if get_tree().current_scene.name == "World":
		happiness -= 0.01
	if timer > 0:
		timer -= 1
	if happiness < 1 and get_tree().current_scene.name == "World":
		for pawn in get_tree().get_nodes_in_group("Pawns"):
			pawn.queue_free()
		get_tree().change_scene("res://Scenes/Game Over.tscn")


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

func reset():
	timer = 10
	happiness = 100
	get_tree().change_scene("res://Scenes/World.tscn")
