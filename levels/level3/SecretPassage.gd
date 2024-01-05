extends Node

func run(tid):
	if tid in [4, 6, 7]:
		get_parent().get_node("Label").visible = true
	elif tid in [2, 3, 5]:
		get_parent().get_node("SecretGround").show()
		get_parent().emit_signal("finish_pos", 9100)
