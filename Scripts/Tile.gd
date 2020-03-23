extends Node2D

class_name Tile
onready var powerup_sprite: Sprite = $"PowerupSprite"
var health: float
export var max_health: float
var marked_for_digging = false
var hover:bool = false
var digging: bool = false
onready var particles: PackedScene = preload("res://Scenes/Particles.tscn")
onready var hp_bar = $TextureProgress
var init = true
var camera
onready var anim: AnimationPlayer = $AnimationPlayer
onready var timer = $Timer
var angle = 0
export var max_angle = 45
onready var sprite = $Sprite
var powerup = 0
var is_gem = false
onready var world = $"/root/World"
onready var err = world.find_node("Error")
onready var succ = world.find_node("Success")
enum powerups {NONE, TIME_DOWN, POP_UP}
var time_down_chance = 0.1
var pop_up_chance = 0.1
var gem_chance = 0.1
var woosh = Autoload.woosh
var click = Autoload.click

func _ready() -> void:
	max_health = (position.y / 16) * ((position.y / 16) * 0.5)
	health = max_health
	randomize()
	if randf() < gem_chance:
		is_gem = true
		powerup_sprite.texture = Autoload.gem_sprite
		powerup_sprite.scale = Vector2(0.066,0.066)
		powerup_sprite.modulate = Color(1,1,1,0)
	elif randf() < time_down_chance:
		$"Discover Area".queue_free()
		powerup_sprite.texture = Autoload.time_down_sprite
		powerup = powerups.TIME_DOWN
	elif randf() < pop_up_chance:
		$"Discover Area".queue_free()
		powerup_sprite.texture = Autoload.pop_up_sprite
		powerup = powerups.POP_UP
		powerup_sprite.scale = Vector2(0.015, 0.015)
	else:
		$"Discover Area".queue_free()
		powerup_sprite.queue_free()
	camera = $"/root/World/Camera2D"
	health = max_health
	

func _process(delta: float) -> void:
	if powerup == 2:
		if Autoload.colorblind:
			powerup_sprite.texture = Autoload.powerup_3_sprite_alt
		else:
			powerup_sprite.texture = Autoload.pop_up_sprite

func _input(event):
	if hover:
		if Input.is_action_pressed("click"):
			if not Autoload.bombing and not marked_for_digging:
				mark()
				Input.set_custom_mouse_cursor(Autoload.cursor)
		elif Input.is_action_pressed("rclick") and not Autoload.bombing and marked_for_digging:
			unmark()

func dig():
	angle = max_angle * (1-health/max_health)
	sprite.rotation_degrees = lerp(sprite.rotation_degrees,Autoload.random(angle,-angle), 0.05)
	timer.start()
	digging = true
	if digging:
		hp_bar.visible = true
	hp_bar.value = health/max_health * 100
	$AnimationPlayer.play("Dig")
	health -= 1

func mark():
	anim.playback_speed = 1	
	marked_for_digging = true
	if Autoload.colorblind:
		modulate = Autoload.colorblind_color
	else:
		modulate = Autoload.normal_color
	Autoload.woosh.pitch_scale = rand_range(0.9,1.1)
	Autoload.woosh.play()
		
	
func unmark():
	hp_bar.visible = false
	marked_for_digging = false
	modulate = Color(1,1,1)
	Autoload.click.pitch_scale = rand_range(0.8,1.2)
	Autoload.click.play()

func _on_Area2D_mouse_entered() -> void:
	hover = true


func _on_Area2D_mouse_exited() -> void:
	hover = false


func _on_Timer_timeout() -> void:
	hp_bar.visible = false
	sprite.rotation_degrees = 0


func _on_Discover_Area_mouse_entered() -> void:
	if is_gem  and !marked_for_digging:
		anim.play("Gem Found")


func _on_Discover_Area_mouse_exited() -> void:
	if is_gem and !marked_for_digging:
		anim.play_backwards("Gem Found")

func play_random_sound():
	if randf() < 0.33:
		click.volume_db = rand_range(-10,-5)
		click.pitch_scale = rand_range(0.7,1.1)
		click.play()

func _on_Health_Watch_timeout():
	if health <= 0:
		if is_gem:
			Autoload.gems += 1
		if powerup == 1:
			Autoload.happiness -= 10
			err.pitch_scale = rand_range(0.9,1.1)
			err.play()
		elif powerup == 2:
			Autoload.pop_cap += 2
			succ.pitch_scale = rand_range(0.9,1.1)
			succ.play()
		var p = particles.instance()
		p.position = position
		get_tree().get_root().add_child(p)
		if position.y > Autoload.depth:
			Autoload.depth = position.y
		world.get_child(8).position = position
		world.get_child(8).volume_db = rand_range(-5,5)		
		world.get_child(8).pitch_scale = rand_range(0.8,1.2)		
		world.get_child(8).play()
		queue_free()
