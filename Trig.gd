extends Node2D

signal fired

enum types {TIMETRIG,
			XTRIG,
			YTRIG,
			TOUCHTRIG}

var type = 0
var id

func init(tp, i, cfg=0):
	type = tp
	if type == types.TIMETRIG:
		var timer = Timer.instance()
		timer.wait_time = cfg
		timer.connect("timeout", self, "_on_Timer_fired")
		add_child(timer)
		timer.start()
	else:
		position = cfg
	print("Instanced Trigger ", i, " Type: ", type)
	id = i

func _on_Player_moved(pos):
	var tx = false
	if type == types.TIMETRIG:
		return
	if myround(pos.x) == position.x:
		if type == types.XTRIG:
			fire()
			return
		elif type == types.TOUCHTRIG:
			tx = true
	if myround(pos.y) == position.y:
		if type == types.YTRIG:
			fire()
		elif type == types.TOUCHTRIG and tx:
			fire()

func _on_Timer_fired():
	fire()

func fire():
	emit_signal("fired", id)
	print("Trigger ", id, " fired. Type: ", type)

func myround(input):
	var third = int(input) % 50
	if third < 25:
		return int(input / 50) * 50
	return (int(input / 50) + 1) * 50
