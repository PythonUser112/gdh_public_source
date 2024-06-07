extends Container

signal data

var pos = Vector2()

func add_level(name, type, prog_norm, prog_practise, color):
	var ls = Loader.bload("LevelShower.tscn")
	ls.init(name, prog_norm, prog_practise, type, color)
	ls.connect("pressed", self, "_on_pressed")
	ls.position = pos
	pos.x += 1100
	add_child(ls)

func _on_pressed(level):
	emit_signal("data", level)
