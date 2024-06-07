extends TextureProgress

func _on_Main_start():
	value = 0

func change_progress(new_prog):
	if new_prog < 40:
		texture_progress = preload("res://assets/barHorizontal_red_mid 200.png")
	elif value < 70:
		texture_progress = preload("res://assets/barHorizontal_yellow_mid 200.png")
	else:
		texture_progress = preload("res://assets/barHorizontal_green_mid 200.png")
	value = new_prog


func _on_Main_progress_changed(prog):
	change_progress(prog)
