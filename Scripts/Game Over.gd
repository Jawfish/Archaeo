extends Node


onready var score = $Score
onready var font_color: Color = $TextureButton/Label.get_color("font_color")

func _ready() -> void:
	Input.set_custom_mouse_cursor(null)
	if Autoload.depth > 0:
		score.text = "Gems    Discovered:    " + str(Autoload.gems)
	else:
		score.text = "Gems    Discovered:    " + str(0)
	$AnimationPlayer.play("Init")


func _on_YES_pressed() -> void:
	Autoload.reset()


func _on_NO_pressed() -> void:
	get_tree().quit()


func _on_TextureButton_mouse_entered():
	$TextureButton/Label.add_color_override("font_color", Color(1,1,1))


func _on_TextureButton_mouse_exited():
	$TextureButton/Label.add_color_override("font_color", font_color)


func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/Credits.tscn")
