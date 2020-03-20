extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TextureButton_pressed():
	OS.shell_open("https://incompetech.filmmusic.io/song/4459-takeover-of-the-8-bit-synths")


func _on_Back_pressed():
	get_tree().change_scene("res://Scenes/Splash.tscn")
