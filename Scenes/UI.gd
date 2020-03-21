extends CanvasLayer

onready var anim: AnimationPlayer = $AnimationPlayer
onready var progress: Label = $Node2D/Happiness/Label
onready var pop: Label = $Node2D/Population/Label
onready var gems: Label = $Node2D/Gem/Label
onready var gear: Texture = load("res://Assets/Images/gear.svg")
onready var gear2: Texture = load("res://Assets/Images/gear2.svg")

#onready var bomb_timer: Timer = $Bomb/Timer
#var bomb_ready = true
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	$"Bomb/Bomb Anim".play("Bomb Ready")

#func _input(event: InputEvent) -> void:
#	if Input.is_action_just_pressed("rclick") and Autoload.bombing:
#		Autoload.bombing = false
##		bomb_ready = true
#		$Bomb.modulate = Color(1,1,1,1)
#		Input.set_custom_mouse_cursor(Autoload.cursor)

func _process(delta: float) -> void:
	if int(gems.text) < Autoload.gems:
		$Gem2.play()
		anim.play("Gem Get")
	gems.text = str(Autoload.gems)
	if int(pop.text.right(2)) < Autoload.pop_cap:
		anim.play("Pop Up")
	pop.text = str(Autoload.pop) + "/" + str(Autoload.pop_cap)
#	if Autoload.bombing == false and bomb_timer.is_stopped():
#		bomb_timer.start()
#	if bomb_ready:
#		$"Bomb/Bomb Ready".visible = true
#	else:
#		$"Bomb/Bomb Ready".visible = false
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
	Autoload.colorblind = button_pressed
	if button_pressed:
		$TextureButton/Sprite.texture = gear2
		for tile in get_tree().get_nodes_in_group("Tiles"):
			if tile.marked_for_digging:
				tile.modulate = Autoload.colorblind_color
	else:
		$TextureButton/Sprite.texture = gear
		for tile in get_tree().get_nodes_in_group("Tiles"):
			if tile.marked_for_digging:
				tile.modulate = Autoload.normal_color

func _on_Motion_Sickness_toggled(button_pressed: bool) -> void:
	Autoload.camera_shake = !button_pressed


#func _on_Timer_timeout() -> void:
##	bomb_ready = true
#	$Bomb.modulate = Color(1,1,1,1)

#func _on_TextureButton2_pressed() -> void:
#	if bomb_ready:
#		Autoload.bombing = true
#		bomb_ready = false
#		$Bomb.modulate = Color(1,1,1,0.25)
#		Input.set_custom_mouse_cursor(Autoload.bomb_cursor)
#		bomb_timer.stop()
#	elif Autoload.bombing:
#		Autoload.bombing = false
#		bomb_ready = true
#		$Bomb.modulate = Color(1,1,1,1)
#		Input.set_custom_mouse_cursor(Autoload.cursor)


func _on_Mute_pressed():
	Autoload.mute()


func _on_Control_Icon_Despawn_timer_timeout() -> void:
	$Controls.free()
	$Controls2.free()
