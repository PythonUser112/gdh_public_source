extends Node

var _on_Player_dead

func init(dead_func):
	_on_Player_dead = dead_func
	get_parent().get_node("Viewport/Level4Scene3D/TileMapToTile3D").init()
	var player = get_node("../Viewport/Level4Scene3D/PlayerCube3D")
	player.connect("progress", get_parent(), "send_progress")
	player.connect("dead", self, "_on_Player_dead")
	player.connect("finished", get_parent(), "_on_Player_finished")
	print("Hi!")

func start():
	return true
