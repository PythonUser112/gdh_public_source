extends Control

func _ready():
	$ColorRect.color = Color(1, 0, 0)
	var scene = Loader.nload("Main.tscn")
	$HBoxContainer/TextureProgress.value = 33
	var child = scene.instance()
	$HBoxContainer/TextureProgress.value = 66
	add_child(child)
	$HBoxContainer/TextureProgress.value = 100
	$ColorRect.hide()
	$HBoxContainer.hide()
