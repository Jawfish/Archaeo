extends KinematicBody2D

var gravity_vector: Vector2 = Vector2(0, 400)
export var move_speed_min:int = 22
export var move_speed_max:int = 28
var move_speed:float = 25
var placed: bool = false
onready var pawn_area: Area2D = $Area2D
var dir = 0
var flip_timer = 0
onready var viewport_width = get_viewport_rect().size.x
onready var anim = $AnimationPlayer


var skin_tones: Array = [Color(0.55,0.33,.14), Color(0.77,0.52,0.25), Color(0.878, 0.674, 0.411), Color(0.945, 0.76, 0.49), Color(1, 0.858, 0.674)]

var velocity: Vector2 = Vector2(0, 0)

func _ready() -> void:
	randomize()
	move_speed = rand_range(move_speed_min, move_speed_max)
	anim.playback_speed = move_speed / move_speed_max
	z_index = Autoload.random(-1,1)
	dir = Autoload.random(-1,1)
	modulate  = random_skin_tone()
	position = get_global_mouse_position()
	
func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity += gravity_vector * delta
	velocity.x = dir * move_speed
	flip_timer -= 1
	if (position.x < 0 or position.x > viewport_width) and flip_timer <= 0:
		flip_timer = 100
		dir = -dir
	
	if is_on_wall():
		velocity.y = -50

func random_skin_tone():
	randomize()
	return skin_tones[floor(rand_range(0, skin_tones.size()))]
