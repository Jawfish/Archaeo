extends KinematicBody2D

var gravity_vector: Vector2 = Vector2(0, 400)
export var move_speed_min:int = 30
export var move_speed_max:int = 40
var move_speed:float = 25
var placed: bool = false
var dir = -1
onready var anim = $AnimationPlayer
var default_scale = 0.25
var fire_dig = true

var payload = 0

onready var left_ray = $Left
onready var right_ray = $Right
onready var down_ray = $Down

var scream = true

var skin_tones: Array = [Color(0.55,0.33,.14), Color(0.77,0.52,0.25), Color(0.878, 0.674, 0.411), Color(0.945, 0.76, 0.49), Color(1, 0.858, 0.674)]

var velocity: Vector2 = Vector2(0, 0)

func _ready() -> void:
	randomize()
	move_speed = rand_range(move_speed_min, move_speed_max)
	anim.playback_speed = move_speed / move_speed_max
	z_index = Autoload.random(-1,1)
	dir = Autoload.random(-1,1)
	var tone = random_skin_tone()
	$Body.modulate  = tone
	$Head.modulate  = tone
	scale.x = scale.x * -dir	
	
	
func _physics_process(delta: float) -> void:
	velocity = move_and_slide(velocity, Vector2(0, -1))
	velocity += gravity_vector * delta
	velocity.x = dir * move_speed
	if left_ray.is_colliding():
		if left_ray.get_collider().get_parent().marked_for_digging == true:
			dig(left_ray.get_collider())
	if right_ray.is_colliding():
		if right_ray.get_collider().get_parent().marked_for_digging == true:
			dig(right_ray.get_collider())
	if is_on_floor():
		if down_ray.is_colliding():
			if down_ray.get_collider().get_parent().marked_for_digging == true:
				dig(down_ray.get_collider())
	if is_on_wall():
		flip()
	else:
		anim.playback_speed = 1
	if (position.x > 110 and position.x < 130) and scream:
		scream = false
		$AudioStreamPlayer2D.pitch_scale = rand_range(0.8,1.2)
		$AudioStreamPlayer2D.play()
	if position.y > 1500:
		Autoload.pop -= 1
		free()
		
	

func random_skin_tone():
	randomize()
	return skin_tones[floor(rand_range(0, skin_tones.size()))]
	
func dig(block):
	anim.play("Dig")
	block.get_parent().dig()
	velocity.x = 0

func flip():
	velocity.x = 0
	scale.x = scale.x * -1
	dir = -dir