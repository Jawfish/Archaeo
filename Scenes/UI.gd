extends CanvasLayer

signal spawn_pawn
onready var anim: AnimationPlayer = $AnimationPlayer
onready var progress: Label = $Happiness/Label
onready var pop: Label = $Population/Label
onready var gems: Label = $Gem/Label
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	progress.text = str(floor(Autoload.happiness))
	pop.text = str(Autoload.pop) + "/" + str(Autoload.pop_cap)
	gems.text = str(Autoload.gems)
	

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
	if Autoload.colorblind:
		for tile in get_tree().get_nodes_in_group("Tiles"):
			if tile.marked_for_digging:
				tile.modulate = Autoload.colorblind_color
	else:
		for tile in get_tree().get_nodes_in_group("Tiles"):
			if tile.marked_for_digging:
				tile.modulate = Autoload.normal_color



func _on_Motion_Sickness_toggled(button_pressed: bool) -> void:
	Autoload.camera_shake = !button_pressed
