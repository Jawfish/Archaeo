extends Node2D

class_name Tile
export var health = 100
var marked_for_digging = false
var index: Vector2
var hover:bool = false

func _process(delta: float) -> void:
	if health <= 0:
		queue_free()
	if hover:
		if Input.is_action_pressed("click"):
			mark()
		elif Input.is_action_pressed("rclick"):
			unmark()
	

func dig(dig_strength: int):
	health -= dig_strength

func mark():
	marked_for_digging = true
	modulate = Color(1.25,1.25,0.75)
	
func unmark():
	marked_for_digging = false
	modulate = Color(1,1,1)


func _on_Area2D_mouse_entered() -> void:
	hover = true


func _on_Area2D_mouse_exited() -> void:
	hover = false
