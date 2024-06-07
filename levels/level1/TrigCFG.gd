extends Node

var times = {}
onready var fb = get_parent().get_node("FlyingBox")
onready var handlers = [fb, fb]

func _ready():
	fb.init(Vector2(4, 1), Vector2(7050, -2050), Vector2(7050, 450), 0, 100000000,
	350)
	fb.position = Vector2(7050, 450)

func get_cfg(_trig_id):
	return times[_trig_id]

func get_handler(tid):
	return handlers[tid]
