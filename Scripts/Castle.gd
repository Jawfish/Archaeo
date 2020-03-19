extends Node2D


onready var anim = $AnimationPlayer
onready var timer = $Timer


func _ready() -> void:
	timer.wait_time = 1 / Autoload.spawn_rate


func _on_Timer_timeout() -> void:
	timer.wait_time = 1 / Autoload.spawn_rate
	if Autoload.pop < Autoload.pop_cap:
		Autoload.pop += 1
		Autoload.place_pawn($"Spawn Point".global_position)
