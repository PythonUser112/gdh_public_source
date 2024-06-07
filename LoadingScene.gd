extends Control

func _ready():
	$ColorRect.color = Color(1, 0, 0)
	var scene = Loader.nload("Main.tscn")
	$HBoxContainer/TextureProgress.value = 16
	var title_screen = Loader.nload("Title.tscn")
	$HBoxContainer/TextureProgress.value = 33
	var child = scene.instance()
	$HBoxContainer/TextureProgress.value = 39
	var anim = title_screen.instance()
	$HBoxContainer/TextureProgress.value = 66
	add_child(child)
	child.hide()
	$HBoxContainer/TextureProgress.value = 83
	add_child(anim)
	$HBoxContainer/TextureProgress.value = 100
	$ColorRect.hide()
	$HBoxContainer.hide()
	anim.start()
	child.show()
	child.start()
