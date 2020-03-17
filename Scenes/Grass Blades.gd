extends Node2D

onready var sprite = $Grass
onready var tween = $Tween

func _ready() -> void:
	var not_green = rand_range(0,0.8)
	modulate = Color(not_green,1,not_green,Autoload.random(0,1))
	z_index = Autoload.random(-1,1)




func _on_Area2D_body_entered(body: Node) -> void:
	$Tween.interpolate_property(self, "rotation", 0, rand_range(-0.5,0.5), 0.1, Tween.TRANS_EXPO)	
	$Tween.start()




func _on_Area2D_body_exited(body: Node) -> void:
	$Tween.interpolate_property(self, "rotation", rotation, 0, 0.1, Tween.TRANS_BOUNCE)	
	$Tween.start()
