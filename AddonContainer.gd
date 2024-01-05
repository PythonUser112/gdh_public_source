extends Control

signal back


func _on_Back_pressed():
	hide()
	emit_signal("back")

func load_addons():
	var f = File.new()
	if f.file_exists("user://addons.txt"):
		f.open("user://addons.txt")
		f.close()

func _on_Inst_pressed():
	$InstDial.show()
	$VBoxContainer.hide()


func _on_Mng_pressed():
	$VBoxContainer.hide()
	load_addons()
	$Addons.show()


func _on_Button_pressed():
	Loader.install_addon($InstDial/Name.text)
	$InstDial.hide()
	$VBoxContainer.show()
