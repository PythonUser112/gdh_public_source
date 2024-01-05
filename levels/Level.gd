extends Node2D

signal finish_pos

var item = Loader.nload("Item.tscn")
var trigger = Loader.nload("Trig.tscn")
var trig_handler = Loader.nload("TrigHandler.tscn")

func init():
	var Items = get_parent().get_node("Items")
	var triggers2 = []
	if get_parent().has_node("Triggers"):
		var triggers = get_parent().get_node("Triggers")
		var TrigCFG = get_parent().get_node("TrigCFG")
		TrigCFG._ready()
		triggers.hide()
		var thandler = trig_handler.instance()
		var _trig_id = 0
		for triggercell in triggers.get_used_cells():
			var id = triggers.get_cellv(triggercell)
			var type = triggers.tile_set.tile_get_name(id)
			var pos = triggers.map_to_world(triggercell) + Items.cell_size / 2
			var trig = trigger.instance()
			var trigtp = {"BTS.png 11":3, "STS.png 12":0,
					  "CS.png 4":1, "Finish.png 6":2}[type]
			var cfg
			if trigtp == 0:
				cfg = get_parent().get_cfg(_trig_id)
			else:
				cfg = pos
			if false:
				print("(", pos, ", ", trigtp,", " ,  _trig_id, ")")
			thandler.add_handler(_trig_id, TrigCFG.get_handler(_trig_id))
			trig.init(trigtp, _trig_id, cfg)
			trig.connect("fired", thandler, "_on_Trigger_fired")
			add_child(trig)
			triggers2.append(trig)
			_trig_id += 1
		print(thandler.handle_methods)
		add_child(thandler)
	var items = []
	Items.hide()
	get_parent().get_node("Audio").play()
	for cell in Items.get_used_cells():
		var id = Items.get_cellv(cell)
		var type = Items.tile_set.tile_get_name(id)
		var pos = Items.map_to_world(cell) + Items.cell_size / 2
		match type:
			'CS.png 4':
				var _item = item.instance()
				_item.position = pos
				_item.init("Circle")
				add_child(_item)
				items.append(_item)
			'JBSU.png 10':
				var _item = item.instance()
				_item.position.y = pos.y + Items.cell_size.y/2
				_item.position.x = pos.x
				_item.init("Jumping Board U")
				add_child(_item)
				items.append(_item)
			'JBSO.png 8':
				var _item = item.instance()
				_item.position.y = pos.y - Items.cell_size.y/2
				_item.position.x = pos.x
				_item.init("Jumping Board O")
				add_child(_item)
				items.append(_item)
			'JBSL.png 7':
				var _item = item.instance()
				_item.position.x = pos.x - Items.cell_size.y/2
				_item.position.y = pos.y
				_item.init("Jumping Board L")
				add_child(_item)
				items.append(_item)
			'JBSR.png 9':
				var _item = item.instance()
				_item.position.x = pos.x + Items.cell_size.y/2
				_item.position.y = pos.y
				_item.init("Jumping Board R")
				add_child(_item)
				items.append(_item)
			'Finish.png 6':
				emit_signal("finish_pos", pos.x)
	return [items, triggers2]
