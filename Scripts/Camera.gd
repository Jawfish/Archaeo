extends Camera2D

export var pan_amount = 3

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and position.y > 200:
		position.y -= pan_amount
	if Input.is_action_pressed("ui_down") and position.y < 1550:
		position.y += pan_amount


