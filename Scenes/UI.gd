extends CanvasLayer

signal spawn_pawn
onready var bar: ProgressBar = $ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	bar.value = Autoload.happiness

func _on_SpawnPawn_toggled(button_pressed: bool) -> void:
	Autoload.placing_pawn = !Autoload.placing_pawn
	print(Autoload.placing_pawn)
