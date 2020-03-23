extends Node

signal cb

onready var powerup_1_sprite = load("res://Assets/Images/clock.svg")
onready var powerup_2_sprite = load("res://Assets/Images/Pawn.png")
onready var powerup_3_sprite_alt = load("res://Assets/Images/pawn_blue.png")
onready var powerup_3_sprite = load("res://Assets/Images/happy.png")
onready var default_volume = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
onready var clunk = load("res://Assets/Sounds/clunk.wav")
var grass: PackedScene = preload("res://Scenes/Grass.tscn")
var dirt: PackedScene = preload("res://Scenes/Dirt.tscn")
var rock: PackedScene = preload("res://Scenes/Rock.tscn")
var pawn: PackedScene = preload("res://Scenes/Pawn.tscn")
var world: PackedScene = preload("res://Scenes/World.tscn")
var game_over: PackedScene = preload("res://Scenes/Game Over.tscn")
var cursor = load("res://Assets/Images/cursor.png")
var bomb_cursor = load("res://Assets/Images/bomb_cursor.png")
var discover_area = preload("res://Scenes/Discover Area.tscn")
var gem_sprite = load("res://Assets/Images/gem.svg")
var pop_up_sprite = load("res://Assets/Images/Pawn.png")
var time_down_sprite = load("res://Assets/Images/clock_minus.svg")
var click: AudioStreamPlayer2D
var woosh: AudioStreamPlayer2D

var colorblind_color: Color = Color(0.75,0.75,1.25)
var normal_color: Color = Color(1.2,1.2,0.9)
var timer = 10
var happiness = 60
var spawn_rate:float = 1
var colorblind: bool = false
var pop = 0
var pop_cap = 10
var depth = 0
var gems = 0
var map_generated: bool = false
var left: bool = true
var bombing = false
var mouse_pos
var muted:bool = false

func _process(delta: float) -> void:
	if map_generated:
		happiness -= delta
	if timer > 0:
		timer -= 1
	if happiness < 1 and map_generated:
		map_generated = false
		for pawn in get_tree().get_nodes_in_group("Pawns"):
			pawn.queue_free()
		get_tree().get_root().get_node("World").get_node("AudioStreamPlayer").stop()
		get_tree().change_scene_to(game_over)

func random(a, b):
	randomize()
	if randi() % 2 == 0:
		return a
	else:
		return b

func place_pawn(position: Vector2):
		if happiness > 0:
			var pawn_instance = pawn.instance()
			pawn_instance.position = position
			$".".add_child(pawn_instance)

func reset():
	map_generated = true
	gems = 0
	pop_cap = 10
	pop = 0
	depth = 0
	timer = 10
	happiness = 60
	get_tree().change_scene("res://Scenes/World.tscn")

func mute():
	muted = !muted
	if AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))  == default_volume:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), default_volume)		
