extends Control
signal main_menu
var containers = []
var block_skins = []
var ship_skins = []
var image:Sprite

func _ready():
	var f = File.new()
	if f.file_exists("user://block_skins.txt"):
		f.open("user://block_skins.txt", File.READ)
		var cont = f.get_as_text()
		block_skins = cont.split(";")
		f.close()
	else:
		block_skins = ["Player1.png"]
	if f.file_exists("user://ship_skins.txt"):
		f.open("user://ship_skins.txt", File.READ)
		var cont = f.get_as_text()
		ship_skins = cont.split(";")
		f.close()
	else:
		ship_skins = ["Ship1.png"]

func init():
	for obj in containers:
		get_node(obj).hide()

func _on_BackButton_pressed():
	hide()
	emit_signal("main_menu")

func load_skins():
	var img
	var container = TabContainer.new()
	var bs = VBoxContainer.new()
	container.add_font_override("font", Loader.nload("assets/font_small.tres"))
	bs.name = "Blockskin"
	for skin in block_skins:
		img = Button.new()
		img.expand_icon = true
		img.text = skin
		img.add_font_override("font", Loader.nload("assets/font_small.tres"))
		img.icon = Loader.nload("assets/playerskins/"+skin) as Texture
		img.connect("pressed", self, "blockskin", [skin])
		bs.add_child(img)
	container.add_child(bs)
	var ss = VBoxContainer.new()
	ss.name = "Shipskin"
	for skin in ship_skins:
		img = Button.new()
		img.text = skin
		img.add_font_override("font", Loader.nload("assets/font_small.tres"))
		img.expand_icon = true
		img.icon = Loader.nload("assets/playerskins/"+skin) as Texture
		img.connect("pressed", self, "shipskin", [skin])
		ss.add_child(img)
	container.add_child(ss)
	$Skins.add_child(container)

func _on_Skins_pressed():
	if not $Skins.has_node("SkinsCreated"):
		$Skins.margin_top = 20
		$Skins.margin_left = 20
		var bb = Button.new()
		bb.icon = load("res://icon.png") as Image
		bb.text = "Back"
		bb.add_font_override("font", Loader.nload("assets/font_small.tres"))
		bb.connect("pressed", self, "_back_skins")
		$Skins.add_child(bb)
		image = Sprite.new()
		load_skins()
		$Skins.add_child(image)
		var x = Node.new()
		x.name = "SkinsCreated"
		$Skins.add_child(x)
	$Skins.show()
	$Buttons.hide()

func shipskin(name):
	image.texture = Loader.nload("assets/playerskins/"+name)
	PlayerControl.skins["ship"] = name

func blockskin(name):
	image.texture = Loader.nload("assets/playerskins/"+name)
	PlayerControl.skins["block"] = name

func _back_skins():
	$Skins.hide()
	$Buttons.show()
