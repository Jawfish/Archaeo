extends Node2D


onready var anim = $AnimationPlayer
onready var timer = $Timer
export var left: bool

func _ready() -> void:
	timer.wait_time = 1 / Autoload.spawn_rate


func _on_Timer_timeout() -> void:
	timer.wait_time = 1 / Autoload.spawn_rate
	if Autoload.pop < Autoload.pop_cap:
		left = !left
		if left:
			Autoload.pop += 1
			Autoload.place_pawn($"Spawn Point".global_position)
