extends Node2D


onready var anim = $AnimationPlayer

func _on_TextureButton_pressed() -> void:	
	Autoload.place_pawn($"Spawn Point".global_position)
	anim.play("Click")
