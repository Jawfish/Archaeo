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
onready var anim = $AnimationPlayer



func _ready() -> void:
	camera = $"/root/World/Camera2D"
	health = max_health

func _process(delta: float) -> void:
	if init and camera.position.y > position.y - 105:
		init = false
		anim.playback_speed = rand_range(3,4)
		anim.play("Init")
	if health <= 0:
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
