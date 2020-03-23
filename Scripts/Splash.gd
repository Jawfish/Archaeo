extends Node

onready var audio = $AudioStreamPlayer
onready var audio2 = $Grind2
onready var clunk = $Clunk

func play_sound():
	audio.play()

func play_sound2():
	audio2.play()

func play_clunk():
	clunk.volume_db = rand_range(-15, -10)
	clunk.pitch_scale = rand_range(0.7,0.9)
	clunk.play()
	
func play_big_clunk():
	clunk.pitch_scale = 0.4
	clunk.volume_db = -5
	clunk.play()
