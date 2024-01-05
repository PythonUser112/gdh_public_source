extends Control
signal main_menu
var containers = []
var block_skins = []
var ship_skins = []

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

func init():
	for obj in containers:
		get_node(obj).hide()

func _on_BackButton_pressed():
	hide()
	emit_signal("main_menu")

func load_skins():
	var img
	var bs = VBoxContainer.new()
	for skin in block_skins:
		img = Button.new()
		img.expand_icon = true
		img.text = skin
		img.icon = Loader.nload("assets/playerskins/"+skin) as Texture
		img.connect("pressed", self, "_blockskin_"+skin.split(".")[0])
		bs.add_child(img)
	$Skins.add_child(bs)
	var ss = VBoxContainer.new()
	for skin in ship_skins:
		img = Button.new()
		img.text = skin
		img.expand_icon = true
		img.icon = Loader.nload("assets/playerskins/"+skin) as Texture
		img.connect("pressed", self, "_shipskin_"+skin.split(".")[0])
		ss.add_child(img)
	img = Button.new()
	img.text = "Ship.png"
	img.expand_icon = true
	img.icon = Loader.nload("assets/Ship.png") as Texture
	img.connect("pressed", self, "_shipskin_Ship")
	ss.add_child(img)
	$Skins.add_child(ss)


func _on_Skins_pressed():
	if not $Skins.has_node("SkinsCreated"):
		$Skins.margin_top = 100
		$Skins.margin_left = 100
		load_skins()
		var x = Node.new()
		x.name = "SkinsCreated"
		$Skins.add_child(x)
		var bb = Button.new()
		bb.icon = load("res://icon.png") as Image
		bb.text = "Back"
		#bb.font = Loader.nload("assets/Font.tres")
		bb.connect("pressed", self, "_back_skins")
		$Skins.add_child(bb)
	$Skins.show()
	$Buttons.hide()

func _back_skins():
	$Skins.hide()
	$Buttons.show()
