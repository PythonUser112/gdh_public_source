extends Node

signal set_factors
signal zoom
signal rotate

var pos = Vector2()

func zoom(xf, yf):
	emit_signal("zoom", xf, yf)

func grotate(degs):
	emit_signal("rotate", degs)

func set_factors(xf, yf):
	emit_signal("set_factors", xf, yf)

func progress(_pos):
	pos = _pos 

func get_pos():
	return pos
