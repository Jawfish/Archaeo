extends Camera2D

export var pan_amount = 3
onready var camera_rect = get_camera_rect(self)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("ui_up") and position.y > 200:
		position.y -= pan_amount
	if Input.is_action_pressed("ui_down") and position.y < 550:
		position.y += pan_amount
	if Input.is_action_pressed("ui_left") and position.x > camera_rect.w / 2:
		position.x -= pan_amount
	if Input.is_action_pressed("ui_right") and position.x < get_viewport_rect().size.x - camera_rect.w / 2:
		position.x += pan_amount


func get_camera_rect(camera):
	var rect = {"x": 0, "y": 0, "w": 0, "h": 0}
	var cameraPos = camera.get_camera_screen_center()
	var viewportRect = get_viewport_rect().size / 2 * camera.zoom
	rect.x = cameraPos.x - viewportRect.x
	rect.y = cameraPos.y - viewportRect.y
	rect.w = cameraPos.x + viewportRect.x
	rect.h = cameraPos.y + viewportRect.y
	return rect
