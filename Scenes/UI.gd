extends CanvasLayer

onready var anim: AnimationPlayer = $AnimationPlayer
onready var progress: Label = $Happiness/Label
onready var pop: Label = $Population/Label
onready var gems: Label = $Gem/Label
onready var bomb_timer: Timer = $Bomb/Timer
var bomb_ready = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"Bomb/Bomb Anim".play("Bomb Ready")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("rclick") and Autoload.bombing:
		Autoload.bombing = false
		bomb_ready = true
		$Bomb.modulate = Color(1,1,1,1)
		Input.set_custom_mouse_cursor(Autoload.cursor)

func _process(delta: float) -> void:
	pop.text = str(Autoload.pop) + "/" + str(Autoload.pop_cap)
	if int(gems.text) < Autoload.gems:
		$Gem2.play()
		anim.play("Gem Get")
	gems.text = str(Autoload.gems)
	if Autoload.bombing == false and bomb_timer.is_stopped():
		bomb_timer.start()
	if bomb_ready:
		$"Bomb/Bomb Ready".visible = true
	else:
		$"Bomb/Bomb Ready".visible = false
	if Autoload.happiness < 10:
		progress.modulate = Color(1,0,0)
		if int(progress.text) > Autoload.happiness:
			anim.play("Low Timer")
	else:
		progress.modulate = Color(1,1,1)
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


func _on_Timer_timeout() -> void:
	bomb_ready = true
	$Bomb.modulate = Color(1,1,1,1)

func _on_TextureButton2_pressed() -> void:
	if bomb_ready:
		Autoload.bombing = true
		bomb_ready = false
		$Bomb.modulate = Color(1,1,1,0.25)
		Input.set_custom_mouse_cursor(Autoload.bomb_cursor)
		bomb_timer.stop()
	elif Autoload.bombing:
		Autoload.bombing = false
		bomb_ready = true
		$Bomb.modulate = Color(1,1,1,1)
		Input.set_custom_mouse_cursor(Autoload.cursor)


func _on_Mute_pressed():
	Autoload.mute = !Autoload.mute
