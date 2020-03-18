extends Node


onready var score = $Score

func _ready() -> void:
	score.text = "Depth    Reached: 0"
	$AnimationPlayer.play("Init")


func _on_YES_pressed() -> void:
	Autoload.reset()


func _on_NO_pressed() -> void:
	get_tree().quit()
