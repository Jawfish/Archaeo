extends Node2D

func _process(delta: float) -> void:
	position.y += 100 * delta

func _on_Timer_timeout() -> void:
	queue_free()


func _on_TextureButton2_button_down():
	$TextureButton.disabled = true
	Autoload.happiness += 2
	$AnimationPlayer.play("Ded")
