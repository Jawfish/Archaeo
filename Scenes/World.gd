extends Node2D

var powerup: PackedScene = preload("res://Scenes/Powerup.tscn")
const TILE_SIZE: int = 16	
onready var viewport: Vector2 = get_viewport_rect().size
export var sky_height: int = 13
export var grass_height: int = 14
export var dirt_height: int = 26
onready var MAP_WIDTH: int = 16
onready var MAP_HEIGHT: int = 100
onready var light: Light2D = $Light2D
onready var timer: Timer = $"Powerup Timer"
onready var music: AudioStreamPlayer = $AudioStreamPlayer
var show_controls = true
onready var camera: Camera2D = $Camera2D


func _process(delta: float) -> void:
	light.position = get_global_mouse_position()
	if not Autoload.muted and music.volume_db < -5:
		music.volume_db += 0.5

func _ready() -> void:
	Input.set_custom_mouse_cursor(Autoload.cursor)
	for x in MAP_WIDTH:
		for y in MAP_HEIGHT:
			if not ( x == 8 or x == 7):
				if y * TILE_SIZE < sky_height * TILE_SIZE:
					pass
				elif y * TILE_SIZE < grass_height * TILE_SIZE:
					generate_tile(Autoload.grass.instance(), x, y)
				elif y * TILE_SIZE < dirt_height * TILE_SIZE:
					generate_tile(Autoload.dirt.instance(), x, y)
				else:
					generate_tile(Autoload.rock.instance(), x, y)
	Autoload.map_generated = true
	timer.start()
	music.play()


func _on_Powerup_Timer_timeout() -> void:
	print('spawned powerup')
	var p = powerup.instance()
	p.position.x = rand_range(0, 210)
	p.position.y = $Camera2D.position.y - 100
	$".".add_child(p)

func generate_tile(tile, x, y):
	var t = tile
	t.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
	t.health = y * (y * 0.5)
	t.max_health = y * (y * 0.5)
	$".".add_child(t)
