extends KinematicBody2D

var gravity_vector: Vector2 = Vector2(0, 400)
export var move_speed_min:int = 30
export var move_speed_max:int = 40
var move_speed:float = 25
var placed: bool = false
var dir = 0
var flip_timer = 0
onready var up_ray = $Up
onready var anim = $AnimationPlayer
var dig_strength = rand_range(1,1.5)

var payload = 0

onready var left_ray = $Left
onready var right_ray = $Right
onready var down_ray = $Down

var skin_tones: Array = [Color(0.55,0.33,.14), Color(0.77,0.52,0.25), Color(0.878, 0.674, 0.411), Color(0.945, 0.76, 0.49), Color(1, 0.858, 0.674)]

var velocity: Vector2 = Vector2(0, 0)

func _ready() -> void:
	randomize()
	move_speed = rand_range(move_speed_min, move_speed_max)
	anim.playback_speed = move_speed / move_speed_max
	z_index = Autoload.random(-1,1)
	dir = Autoload.random(-1,1)
	modulate  = random_skin_tone()
	
func _physics_process(delta: float) -> void:
	if position.y > 1000:
		Autoload.pop -= 1
		queue_free()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity += gravity_vector * delta
	velocity.x = dir * move_speed
	if is_on_wall():
		flip_timer -= 1
	else:
		flip_timer = 25
	if is_on_wall() and flip_timer <= 0:
		flip_timer = 25
		dir = -dir
	if left_ray.is_colliding():
		if left_ray.get_collider().get_parent().marked_for_digging == true:
			dig(left_ray.get_collider())
	if down_ray.is_colliding():
		if down_ray.get_collider().get_parent().marked_for_digging == true:
			dig(down_ray.get_collider())
	if right_ray.is_colliding():
		if right_ray.get_collider().get_parent().marked_for_digging == true:
			dig(right_ray.get_collider())
	if is_on_wall():
		anim.playback_speed = 0.33
	else:
		anim.playback_speed = 1
	

func random_skin_tone():
	randomize()
	return skin_tones[floor(rand_range(0, skin_tones.size()))]
	
func dig(block):
	block.get_parent().dig(dig_strength)
	velocity.x = 0
