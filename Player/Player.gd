extends Node2D

signal dead
signal progress
signal finished
signal position

var formations = {"Block":Loader.bload("Player/Block.tscn"),
				  "Ship":Loader.bload("Player/Ship.tscn")}
var act_form = formations["Block"]
var transform_items = {"To Block":"Block", "To Ship":"Ship"}

func run():
	act_form._on_Main_start()

func _ready():
	for form in formations.values():
		add_child(form)
		form.sprite.visible = false
		form.connect("dead", self, "_on_dead")
		form.connect("progress", self, "_on_progress")
		form.connect("finished", self, "_on_finished")
		form.connect("pos", self, "_on_moved")
		form.set_process(false)

func set_rotation(degrees):
	for form in formations.values():
		form.grotation = deg2rad(degrees)

func set_factors(xf, yf):
	for form in formations.values():
		form.x_factor = xf
		form.y_factor = yf

func _process(_delta):
	if Input.is_action_pressed("kill_level"):
		emit_signal("dead")
		set_process(false)
		visible = false
		
	$Camera2D.position = act_form.position

func _set_finish_pos(pos):
	for formation in formations.values():
		formation._set_finish_pos(pos)

func _on_progress(prog):
	emit_signal("progress", prog)

func _on_dead():
	emit_signal("dead")
	hide()

func _on_finished():
	print("finished")
	emit_signal("finished")

func _on_Item_entered(item):
	if item in transform_items:
		act_form.set_process(false)
		var pos = act_form.position
		var xf = act_form.x_factor
		var yf = act_form.y_factor
		var rot = act_form.grotation
		act_form = formations[transform_items[item]]
		act_form.position = pos
		act_form.x_factor = xf
		act_form.y_factor = yf
		act_form.grotation = rot
		act_form.set_process(true)
		return
	act_form._on_Item_entered(item)

func _on_Item_leaved(item):
	act_form._on_Item_leaved(item)

func _on_zoom(xz, yz):
	$Camera2D.zoom = Vector2(xz, yz)

func _on_moved(pos):
	emit_signal("position", pos)
