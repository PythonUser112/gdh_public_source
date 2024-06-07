extends Node2D

signal level_choose

export (String) var saving_file = "user://gdh_progress.txt"
var file = File.new()
var level
var dest = 0
var max_pos = 0
var progress = [[0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0], [0, 0]]
var speed = 2

func _on_LevelsContainer_data(_level):
	level = _level
	emit_signal("level_choose", level)

func _input(_event):
	if Input.is_action_just_pressed("ui_right"):
		dest += 1
		if dest > max_pos:
			dest = max_pos
		move()
	if Input.is_action_just_pressed("ui_left"):
		dest -= 1
		if dest < 0:
			dest = 0
		move()


func init(levels):
	get_progress()
	max_pos = len(levels)
	var mlevel = 0
	for _level in levels:
		var name = _level[0]
		var color = _level[1]
		var type = _level[2]
		var norm = progress[mlevel][0]
		var practice = progress[mlevel][1]
		get_parent().get_node("LevelsContainer").add_level(name, type, norm, practice, color)
		mlevel += 1

func move():
	$MoveTween.interpolate_property(self, "position", position, \
	Vector2(dest*1100,0),\
	 1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$MoveTween.start()

func get_progress():
	if file.file_exists(saving_file):
		file.open(saving_file, File.READ)
		var content = file.get_as_text().split(";")
		var index = 0
		for element in content:
			if element == "":
				continue
			progress[int(index/2)][index%2] = int(element)
			index += 1


func _on_Left_pressed():
	dest -= 1
	dest = max(dest, 0)
	move()

func _on_Right_pressed():
	dest += 1
	dest = min(dest, max_pos-1)
	move()
