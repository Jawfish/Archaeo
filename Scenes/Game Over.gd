extends Node


onready var score = $Score

func _ready() -> void:
	Input.set_custom_mouse_cursor(null)
	if Autoload.depth > 0:
		score.text = "Depth    Reached: " + str((floor(Autoload.depth / 16)) - 12)
	else:
		score.text = "Depth    Reached: " + str(0)
	$AnimationPlayer.play("Init")


func _on_YES_pressed() -> void:
	Autoload.reset()


func _on_NO_pressed() -> void:
	get_tree().quit()
