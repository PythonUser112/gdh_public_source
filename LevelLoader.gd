extends Control

signal start
signal progress_changed
signal main_menu
signal position

export (PackedScene) var loadinganim
export (int) var level_choose
export (bool) var _load_on_start = true
export (bool) var retry_on_die = false#true
export (int) var dead_retry_time = 1
export (String) var saving_file = "user://gdh_progress.txt"
var _level = 0
var levels = ["level1", "level2", "level3", "level4", "level5", "level6", "level7"]
var finished = false
var attempt
var player
var map
var new_hiprog = false
var mode = 0 #0:Normal Mode, 1:Practise Mode
var progress = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]

func ll(level_name):
	return Loader.bload("levels/%s/Level.tscn"%level_name)

func change_level(level):
	attempt = 1
	_level = level

func next():
	$GameHUD/MarginContainer.visible = true
	var level = _level
	$MarginContainer2.show()
	$MarginContainer2/Label.text = "Attemp "+str(attempt)
	map = ll(levels[level-1])
	if map.has_node("CustomSetup"):
		if custom_level():
			return
	player = Loader.bload("Player/Player.tscn")
	map.connect("finish_pos", player, "_set_finish_pos")
# warning-ignore:return_value_discarded
	connect("start", player, "run")
	player.connect("progress", self, "send_progress")
	player.connect("dead", self, "_on_Player_dead")
	player.connect("finished", self, "_on_Player_finished")
# warning-ignore:return_value_discarded
	PlayerControl.connect("set_factors", player, "set_factors")
# warning-ignore:return_value_discarded
	PlayerControl.connect("rotate", player, "set_rotation")
# warning-ignore:return_value_discarded
	PlayerControl.connect("zoom", player, "_on_zoom")
	player.connect("position", PlayerControl, "progress")
	var objects = map.init()
	add_child(map)
	add_child(player)
	for item in objects[0]:
		item.connect("activated", player, "_on_Item_entered")
		item.connect("deactivated", player, "_on_Item_leaved")
	for trigger in objects[1]:
		player.connect("position", trigger, "_on_Player_moved")
	emit_signal("start")

func custom_level():
	map.get_node("CustomSetup").init(funcref(self, "_on_Player_dead"))
	return map.get_node("CustomSetup").start()

func _ready():
	var f = File.new()
	if f.file_exists(saving_file):
		f.open(saving_file, File.READ)
		var content = f.get_as_text().split(";")
		var index = 0
		for element in content:
			if element == "":
				continue
			progress[int(index/2)][index%2] = int(element)
			index += 1
	if not _load_on_start:
		$GameHUD/MarginContainer.visible = false
		return
	if level_choose == 0:
		change_level(1)
	else:
		change_level(level_choose)

func save_prog():
	var out = ""
	for level in progress:
		var norm = level[0]
		var practise = level[1]
		out += str(norm)
		out += ";"
		out += str(practise)
		out += ";;"
	var f = File.new()
	f.open(saving_file, File.WRITE)
	f.store_string(out)
	f.close()

func send_progress(_progress):
	if progress[_level-1][mode] < _progress:
		progress[_level-1][mode] = _progress
	$PauseMenuContainer/PauseMenu/Container/ProgressContainer/TextureProgress.value = progress[_level-1][mode]
	$PauseMenuContainer/PauseMenu/Container/ProgressContainer/Label.text = str(progress[_level-1][mode])
	emit_signal("progress_changed", _progress)

func _on_Player_dead():
	if map:
		map.get_node("Audio").stop()
	if new_hiprog:
		save_prog()
	if retry_on_die:
		attempt += 1
		$Timer.wait_time = dead_retry_time
		$Timer.start()
	else:
		hide()
		$GameHUD.hide()
		$PauseMenuContainer/PauseMenu.show()
		get_tree().paused = true

func retry():
	attempt += 1
	player.queue_free()
	map.queue_free()
	$PauseMenuContainer/PauseMenu/Container/ButtonBox/Continue.show()
	$PauseMenuContainer/PauseMenu/Container/Label.text = "Level Paused"
	next()

func _on_Player_finished():
	progress[_level-1][mode] = 100
	save_prog()
	map.get_node("Audio").stop()
	get_tree().paused = true
	hide()
	$GameHUD.hide()
	$PauseMenuContainer/PauseMenu/Container/Label.text = "Level finished!"
	$PauseMenuContainer/PauseMenu/Container/ButtonBox/Continue.hide()
	$PauseMenuContainer/PauseMenu.show()

func _on_Node2D_retry():
	retry()

func _on_Node2D_main_menu():
	emit_signal("main_menu")
	map.queue_free()
	queue_free()

func _retry():
	retry()

func prog(pos):
	emit_signal("position", pos)


func _on_PauseButton_pressed():
	$PauseMenuContainer/PauseMenu.show()
	hide()
	$GameHUD.hide()
	get_tree().paused = true
