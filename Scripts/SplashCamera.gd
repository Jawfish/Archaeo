extends Camera2D

export var decay = 1  # How quickly the shaking stops [0, 1].
export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

export var trauma: float = 0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].

func _ready():
	randomize()

func add_trauma(amount):
	trauma = min(trauma + amount, 1.0)
	
func _process(delta):
	randomize()
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake()
		
func shake():
	var amount = pow(trauma, trauma_power)
	rotation = max_roll * amount * rand_range(-1, 1)
	offset.x = max_offset.x * amount * rand_range(-1, 1)
	offset.y = max_offset.y * amount * rand_range(-1, 1)