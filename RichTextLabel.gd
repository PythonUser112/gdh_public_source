extends Label

func _on_Main_progress_changed(prog):
	text = str(prog) + " %"


func _on_Main_start():
	text = "0 %"
