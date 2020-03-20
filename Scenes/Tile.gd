extends Node2D

class_name Tile
var health: float
export var max_health: float
var marked_for_digging = false
var index: Vector2
var hover:bool = false
var digging: bool = false
onready var particles: PackedScene = preload("res://Scenes/Particles.tscn")
onready var hp_bar = $TextureProgress
var init = true
var camera
onready var anim: AnimationPlayer = $AnimationPlayer
onready var timer = $Timer
var angle = 0
export var max_angle = 20
onready var sprite = $Sprite
var powerup = 0
var in_view = false
var is_gem = false
onready var click = $Click
onready var world = $"/root/World"
onready var err = world.find_node("Error")
onready var succ = world.find_node("Success")
func _ready() -> void:

	randomize()
	var spawn_rate = randf()
	if spawn_rate > 0.2 and spawn_rate < 0.3:
		is_gem = true
	if spawn_rate > 0.05 and spawn_rate < 0.2:
		powerup = 1
		$Powerup1.visible = true
	elif spawn_rate < 0.05:
		powerup = 2
		$Powerup2.visible = true
		

	
	camera = $"/root/World/Camera2D"
	health = max_health
	

func _process(delta: float) -> void:
	if init and camera.position.y > position.y - 80:
		init = false
		anim.playback_speed = rand_range(3,4)
		anim.play("Init")
	if in_view:
		if powerup == 2:
			if Autoload.colorblind:
				$Powerup2.modulate = Color(1,1,5)
			else:
				$Powerup2.modulate = Color(1,1,1)
	if health <= 0:
		if is_gem:
			Autoload.gems += 1
		if powerup == 1:
			Autoload.happiness -= 10
			err.pitch_scale = rand_range(0.9,1.1)
			err.play()
		elif powerup == 2:
			Autoload.pop_cap += 1
			succ.pitch_scale = rand_range(0.9,1.1)
			succ.play()
		var p = particles.instance()
		p.position = position
		get_tree().get_root().add_child(p)
		if Autoload.camera_shake:
			get_parent().find_node("Camera2D").trauma = 0.1
		if position.y > Autoload.depth:
			Autoload.depth = position.y
		world.get_child(8).position = position
		world.get_child(8).volume_db = rand_range(-5,5)		
		world.get_child(8).pitch_scale = rand_range(0.8,1.2)		
		world.get_child(8).play()

		
		call_deferred('free')
	if hover:
		if Input.is_action_pressed("click"):
			if not Autoload.bombing and not marked_for_digging:
				mark()
			if Autoload.bombing:
				dig(9999999)
				Autoload.bombing = false
				Input.set_custom_mouse_cursor(Autoload.cursor)
		elif Input.is_action_pressed("rclick") and not Autoload.bombing and marked_for_digging:
			unmark()
		

func dig(dig_strength: int):
	angle = max_angle * (1-health/max_health)
	sprite.rotation_degrees = lerp(sprite.rotation_degrees,Autoload.random(angle,-angle), 0.05)
	timer.start()
	digging = true
	if digging:
		hp_bar.visible = true
	hp_bar.value = floor(health/max_health * 100)
	$AnimationPlayer.play("Dig")
	health -= dig_strength

func mark():
	anim.playback_speed = 1	
	marked_for_digging = true
	if Autoload.colorblind:
		modulate = Autoload.colorblind_color
	else:
		modulate = Autoload.normal_color
	$Woosh.pitch_scale = rand_range(0.9,1.1)
	$Woosh.play()
		
	
func unmark():
	hp_bar.visible = false
	marked_for_digging = false
	modulate = Color(1,1,1)
	$Click.pitch_scale = rand_range(0.8,1.2)
	$Click.play()

func _on_Area2D_mouse_entered() -> void:
	hover = true


func _on_Area2D_mouse_exited() -> void:
	hover = false


func _on_Timer_timeout() -> void:
	hp_bar.visible = false
	sprite.rotation_degrees = 0

func view_update():
	in_view = true


func _on_Discover_Area_mouse_entered() -> void:
		if is_gem and in_view and !marked_for_digging:
			anim.play("Gem Found")


func _on_Discover_Area_mouse_exited() -> void:
		if is_gem and !marked_for_digging and in_view:
			anim.play_backwards("Gem Found")

func play_random_sound():
	if randf() < 0.33:
		click.volume_db = rand_range(-10,-5)
		click.pitch_scale = rand_range(0.7,1.1)
		click.play()
