extends Node2D


var powerup: PackedScene = preload("res://Scenes/Powerup.tscn")
var dirt: PackedScene = preload("res://Scenes/Dirt.tscn")
const TILE_SIZE: int = 16	
onready var viewport: Vector2 = get_viewport_rect().size
export var sky_height: int = 13
export var grass_height: int = 14
export var dirt_height: int = 26
onready var MAP_WIDTH: int = 16
onready var MAP_HEIGHT: int = 100
onready var light: Light2D = $Light2D
onready var timer: Timer = $"Powerup Timer"
onready var worldgen_timer: Timer = $"Timer"
onready var music: AudioStreamPlayer = $AudioStreamPlayer
var show_controls = true
onready var camera: Camera2D = $Camera2D
var current_camera_y_level:int = 0
var current_generated_y_level: int = 0


func _input(event):
	light.position = get_global_mouse_position()
	if not Autoload.muted and music.volume_db < -5:
		music.volume_db += 0.5

func _ready() -> void:
	Autoload.click = $Click
	Autoload.woosh = $Woosh
	for x in TILE_SIZE:
		for y in 5:
			if (x != 8) and (x != 7):
				generate_tile(dirt.instance(), x, y + 13)
	# generate_tiles_below_view()
	Input.set_custom_mouse_cursor(Autoload.cursor)
	# for x in MAP_WIDTH:
	# 	for y in MAP_HEIGHT:
	# 		if not ( x == 8 or x == 7):
	# 			if y * TILE_SIZE < sky_height * TILE_SIZE:
	# 				pass
	# 			elif y * TILE_SIZE < grass_height * TILE_SIZE:
	# 				generate_tile(Autoload.grass.instance(), x, y)
	# 			elif y * TILE_SIZE < dirt_height * TILE_SIZE:
	# 				generate_tile(Autoload.dirt.instance(), x, y)
	# 			else:
	# 				generate_tile(Autoload.rock.instance(), x, y)
	Autoload.map_generated = true
	timer.start()
	music.play()


func _on_Powerup_Timer_timeout() -> void:
	print('spawned powerup')
	var p = powerup.instance()
	p.position.x = rand_range(0, 210)
	p.position.y = $Camera2D.position.y - 100
	$".".add_child(p)

func generate_tile(tile: Node2D, x: int, y: int):
	tile.position.x = x * TILE_SIZE
	tile.position.y = y * TILE_SIZE
	$".".add_child(tile)
	print("Tile generated at ", tile.position.x, ', ', tile.position.y)


func generate_tiles_below_view():
	# print(tree.get_nodes_in_group("Tiles").size())
	current_camera_y_level = floor(camera.position.y / TILE_SIZE + viewport.y / TILE_SIZE)
	if current_generated_y_level < current_camera_y_level:
		# print(current_generated_y_level)
		# print(current_camera_y_level)
		for x in TILE_SIZE:
			for y in current_camera_y_level - current_generated_y_level:
				if (x != 8) and (x != 7):
					generate_tile(dirt.instance(), x, (current_camera_y_level - y)  + 17)
		current_generated_y_level += current_camera_y_level - current_generated_y_level

func _on_Timer_timeout():
	generate_tiles_below_view()
