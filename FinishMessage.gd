extends Node2D

signal main_menu
signal retry



func _on_Retry_pressed():
	emit_signal("retry")


func _on_MainMenu_pressed():
	emit_signal("main_menu")
