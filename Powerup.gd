extends Node2D

func _process(delta: float) -> void:
	position.y += 100 * delta


func _on_TextureButton_button_down() -> void:
	$TextureButton.disabled = true
	Autoload.happiness += 5
	$AnimationPlayer.play("Ded")

func _on_Timer_timeout() -> void:
	queue_free()
