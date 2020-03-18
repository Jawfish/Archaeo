extends CanvasLayer

signal spawn_pawn
onready var anim: AnimationPlayer = $AnimationPlayer
onready var progress: Label = $Container/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	progress.text = str(floor(Autoload.happiness))

func _on_SpawnPawn_toggled(button_pressed: bool) -> void:
	Autoload.placing_pawn = !Autoload.placing_pawn
	print(Autoload.placing_pawn)



func _on_TextureButton_toggled(button_pressed: bool) -> void:
	if button_pressed:
		anim.play("Options Menu")
	else:
		anim.play_backwards("Options Menu")
		


func _on_Colorblind_toggled(button_pressed: bool) -> void:
	Autoload.colorblind = button_pressed # Replace with function body.



func _on_Motion_Sickness_toggled(button_pressed: bool) -> void:
	Autoload.camera_shake = !button_pressed
