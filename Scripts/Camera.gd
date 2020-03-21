extends Camera2D

export var pan_amount = 3

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and position.y > 200:
		position.y -= pan_amount
	if Input.is_action_pressed("ui_down")  and position.y < 1357:
		position.y += pan_amount
	
func _input(event):
	if not Input.is_action_pressed("ui_up") and not Input.is_action_pressed("ui_down"):
		if Input.is_action_just_released("scroll_up")  and position.y > 200:
			position.y -= pan_amount * 6
		if Input.is_action_just_released("scroll_down")  and position.y < 1357:
			position.y += pan_amount * 6
