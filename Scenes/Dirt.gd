extends Tile


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
onready var ray = $RayCast2D
var is_under_grass: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = 1000
	max_health = 1000

	
func _physics_process(delta: float) -> void:
	if not ray.is_colliding() and is_under_grass:
		is_under_grass = false
		sprite.region_rect = Rect2(0,0,16,16)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
