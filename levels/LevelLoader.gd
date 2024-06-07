extends Node2D
signal finish_pos

func init():
	var levelscript = Loader.nload("levels/Level.gd")
	var fakenode = Node2D.new()
	fakenode.set_script(levelscript)
	fakenode.connect("finish_pos", self, "fpos")
	add_child(fakenode)
	return fakenode.init()

func fpos(pos):
	emit_signal("finish_pos", pos)
