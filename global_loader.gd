extends Node

onready var basic_loader = load("res://Loader.tscn").instance()
onready var norm_loader = basic_loader.bload("Loader.tscn")

func _ready():
	add_child(norm_loader)

func nload(file):
	var date = OS.get_date()
	if date.month == 4 and date.day == 1:
		var out = norm_loader.nload("April"+file)
		if out:
			return out
	return norm_loader.nload(file)

func bload(file):
	var date = OS.get_date()
	if date.month == 4 and date.day == 1:
		var out = norm_loader.nload("April"+file)
		if out:
			return out.instance()
	return norm_loader.bload(file)

func load_addon(addon_name):
	return norm_loader.load_addon(addon_name)

func install_addon(addon_name):
	norm_loader.install_addon(addon_name)
