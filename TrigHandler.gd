extends Node2D

var handle_methods = {}

func add_handler(trigid, handler):
	handle_methods[trigid] = handler

func _on_Trigger_fired(trigid):
	var handler = handle_methods[trigid]
	handler.run(trigid)
