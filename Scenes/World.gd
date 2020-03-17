extends Node2D

var grass: PackedScene = preload("res://Scenes/Grass.tscn")
var dirt: PackedScene = preload("res://Scenes/Dirt.tscn")
var rock: PackedScene = preload("res://Scenes/Rock.tscn")
const TILE_SIZE: int = 16
onready var viewport: Vector2 = get_viewport_rect().size
export var sky_height: int = 13
export var grass_height: int = 14
export var dirt_height: int = 26
onready var MAP_WIDTH: int = 32
onready var MAP_HEIGHT: int = 94

func _ready() -> void:
	for x in MAP_WIDTH:
		for y in MAP_HEIGHT:
			if y * TILE_SIZE < sky_height * TILE_SIZE:
				pass
			elif y * TILE_SIZE < grass_height * TILE_SIZE:
				var grass_tile =  grass.instance()
				grass_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				grass_tile.index = Vector2(x, y)
				$".".add_child(grass_tile)
			elif y * TILE_SIZE < dirt_height * TILE_SIZE:
				var dirt_tile =  dirt.instance()
				dirt_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				dirt_tile.index = Vector2(x, y)
				$".".add_child(dirt_tile)
			else:
				var rock_tile =  rock.instance()
				rock_tile.position = Vector2(x * TILE_SIZE, y * TILE_SIZE)
				rock_tile.index  = Vector2(x, y)
				$".".add_child(rock_tile)
