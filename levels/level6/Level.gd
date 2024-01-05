extends "res://levels/Level2.gd"

var nxf
var nyf = 4
var state = 1
var lock = false
const MAX_POS_X = 2200
const MIN_POS_X = -2200
const START_POS_X = 200
const CONTINUE_POS_X = 800
onready var bg = $CRectLayer/CRect
var _zoom = 0
var bw = false


func set_speed(speed):
	PlayerControl.set_factors(speed, 4)
	
func zoom(factor):
	PlayerControl.zoom(factor, factor)

func _process(_delta):
	var pos = PlayerControl.get_pos()
	match _zoom:
		0:
			if pos.x > START_POS_X:
				bg.color = Color(0, 1, 1)
				zoom(3)
				_zoom += 1
				nxf = 0.5
				$InvisibleSpikes.modulate = Color(1, 1, 1, 1)
				set_speed(nxf)
		1:
			if pos.x > CONTINUE_POS_X:
				bg.color = Color(0.8, 0, 0)
				nxf = 1.5
				set_speed(nxf)
				$InvisibleSpikes.modulate = Color(1, 1, 1, 0)
				zoom(1)
				_zoom += 1
				nxf = 1
	match state:
		3:
			$InvisibleSpikes.modulate = Color(1, 1, 1, 0.125)
		4:
			$InvisibleSpikes.modulate = Color(1, 1, 1, 0.25)
	if state >= 7:
		pass
	elif pos.x >= MAX_POS_X and state % 2 == 1 and not lock:
		state += 1
		set_speed(-nxf)
		lock = true
		$Timer.start()
	elif pos.x <= MIN_POS_X and state % 2 == 0 and not lock:
		state += 1
		set_speed(nxf)
		lock = true
		$Timer.start()


func _on_Timer_timeout():
	lock = false
