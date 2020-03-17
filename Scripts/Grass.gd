extends Tile


func _ready() -> void:
	health = 100
	z_index = Autoload.random(-2,2)
