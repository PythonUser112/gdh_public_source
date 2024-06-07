extends Node2D

func _on_Restart_pressed():
	get_tree().paused = false
	hide()
	get_parent().get_parent().show()
	get_parent().get_parent().get_node("GameHUD").show()
	get_parent().get_parent().retry()

func _on_Continue_pressed():
	get_tree().paused = false
	get_parent().get_parent().show()
	get_parent().get_parent().get_node("GameHUD").show()
	hide()


func _on_ToMenu_pressed():
	get_tree().paused = false
	hide()
	get_parent().get_parent()._on_Node2D_main_menu()
