extends Node

var times = {}
onready var fb = get_parent().get_node("FlyingBox")
onready var handlers = [fb, fb]

func _ready():
	fb.init(Vector2(6, 1), Vector2(4350, -150), Vector2(4350, -450), 0, 1,
	350)
	fb.position = Vector2(4350, -450)

func get_cfg(_trig_id):
	return times[_trig_id]

func get_handler(tid):
	return handlers[tid]
