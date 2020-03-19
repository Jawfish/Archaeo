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
onready var powerup_sprite = $Powerup
onready var powerups = [$Powerup1, $Powerup2, $Powerup3]
var in_view = false
var is_gem = false


func _ready() -> void:
	randomize()
	var spawn_rate = randf()
	if spawn_rate > 0.33 and spawn_rate < 0.4:
		is_gem = true
	if spawn_rate > 0.25 and spawn_rate < 0.33:
		powerup = 1
		$Powerup1.visible = true
	elif spawn_rate < 0.25:
		var n = floor(rand_range(0, powerups.size()))
		if n == 1:
			powerup = 1
			$Powerup1.visible = true
		elif n == 2:
			powerup = 2
			$Powerup2.visible = true
		elif spawn_rate < 0.05: 
			powerup = 3
			$Powerup3.visible = true
	
	camera = $"/root/World/Camera2D"
	health = max_health
	

func _process(delta: float) -> void:
	if init and camera.position.y > position.y - 105:
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
		elif powerup == 2:
			Autoload.pop_cap += 5
		elif powerup == 3:
			Autoload.happiness += 10
		var p = particles.instance()
		p.position = position
		get_tree().get_root().add_child(p)
		if Autoload.camera_shake:
			get_parent().find_node("Camera2D").trauma = 0.1
		if position.y > Autoload.depth:
			Autoload.depth = position.y
		queue_free()
	if hover:
		if Input.is_action_pressed("click"):
			mark()
		elif Input.is_action_pressed("rclick"):
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
	
func unmark():
	hp_bar.visible = false
	marked_for_digging = false
	modulate = Color(1,1,1)


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
		if is_gem:
			anim.play("Gem Found")


func _on_Discover_Area_mouse_exited() -> void:
		if is_gem:
			anim.play_backwards("Gem Found")
