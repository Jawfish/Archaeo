extends Node

var pawn: PackedScene = preload("res://Scenes/Pawn.tscn")

var placing_pawn: bool = false
var timer = 10



func _process(delta: float) -> void:
	if timer > 0:
		timer -= 1

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("click") and timer == 0 and placing_pawn:
		timer = 10
		var pawn_instance = pawn.instance()
		$".".add_child(pawn_instance)

func random(a: int, b:int):
	randomize()
	if randi() % 2 == 0:
		return a
	else:
		return b
