extends Node2D

var grass: PackedScene = preload("res://Scenes/Grass.tscn")
var dirt: PackedScene = preload("res://Scenes/Dirt.tscn")
var rock: PackedScene = preload("res://Scenes/Rock.tscn")
var powerup: PackedScene = preload("res://Scenes/Powerup.tscn")
const TILE_SIZE: int = 16	
onready var viewport: Vector2 = get_viewport_rect().size
export var sky_height: int = 13
export var grass_height: int = 14
export var dirt_height: int = 26
onready var MAP_WIDTH: int = 16
onready var MAP_HEIGHT: int = 70
onready var light: Light2D = $Light2D
onready var timer: Timer = $"Powerup Timer"
onready var music: AudioStreamPlayer = $AudioStreamPlayer


func _process(delta: float) -> void:
	Autoload.mouse_pos = get_global_mouse_position()
	light.position = Autoload.mouse_pos
	if Autoload.mute:
		music.volume_db = -999
	else:
		music.volume_db = -15
	
func _ready() -> void:
	Input.set_custom_mouse_cursor(Autoload.cursor)
	for x in MAP_WIDTH:
		for y in MAP_HEIGHT:
			if y * TILE_SIZE < sky_height * TILE_SIZE:
				pass
			elif y * TILE_SIZE < grass_height * TILE_SIZE:
				var grass_tile =  grass.instance()
				grass_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				grass_tile.index = Vector2(x, y)
				if x == 8 or x==7:
					grass_tile.queue_free()
				$".".add_child(grass_tile)
			elif y * TILE_SIZE < dirt_height * TILE_SIZE:
				var dirt_tile =  dirt.instance()
				dirt_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				dirt_tile.index = Vector2(x, y)
				if x == 8 or x == 7:
					dirt_tile.queue_free()
				$".".add_child(dirt_tile)
			else:
				var rock_tile =  rock.instance()
				rock_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				rock_tile.index  = Vector2(x, y)
				if x == 8 or x == 7:
					rock_tile.queue_free()
				$".".add_child(rock_tile)
	Autoload.map_generated = true
	timer.start()
	


func _on_Powerup_Timer_timeout() -> void:
	print('spawned powerup')
	var p = powerup.instance()
	p.position.x = rand_range(0, 210)
	p.position.y = $Camera2D.position.y - 100
	$".".add_child(p)
