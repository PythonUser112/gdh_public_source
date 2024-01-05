extends Control

export (String) var login_name = "online_player"
var savedir = "user://gdh_player"
var ll = null
var levels = {"Get Started":1, "Pure Verwirrung":2, "Demo":3, "MusicBox":4,
			  "Power Trip 2":6, "Vault of Secrets":7}
var ext = "_progress.txt"

func _ready():
	$MainContainer.show()
	$PlayContainer/Mover.saving_file = savedir+login_name+ext
	$PlayContainer/Mover.init([["Get Started", Color(0, 0, 1), "smiley"],
	["What the fuck?!", Color(1, 0, 0), "hushed"],
	["Demo", Color(0, 1, 0), "wink"],
	["MusicBox", Color(0.75, 0.75, 0.75, 0.75), "musical_note"],
	["Power Trip 2", Color(1, 0, 0), "skull"],
	["Vault of Secrets", Color(0, 0, 1, 0.5), "smiling_imp"]])

func run_level(level):
	$AudioStreamPlayer.stop()
	ll = Loader.bload("LevelLoader.tscn")
	ll.saving_file = savedir+login_name+ext
	ll.connect("main_menu", self, "back_to_menu")
	add_child(ll)
	ll.change_level(level)

func reload_progress():
	$PlayContainer/Mover.saving_file = savedir+login_name+ext

func _on_Options_pressed():
	$MainContainer.hide()
	$OptionsContainer.show()
	$OptionsContainer.init()

func back_to_menu():
	$AudioStreamPlayer.play()
	$MainContainer.show()
	$PlayContainer/Mover/Camera2D.current = false
	$PlayContainer.hide()
	$Camera2D.current = true

func _on_Play_pressed():
	$MainContainer.hide()
	$PlayContainer.show()
	$PlayContainer/Mover/Camera2D.current = true
	$PlayContainer/Mover.get_progress()

func _on_Exit_pressed():
	get_tree().quit()

func _on_Mover_level_choose(level):
	$PlayContainer.hide()
	$PlayContainer/Mover/Camera2D.current = false
	run_level(levels[level])
	ll.next()


func _on_OptionsContainer_main_menu():
	back_to_menu()

func _on_ToMenu_pressed():
	back_to_menu()


func _on_Addons_pressed():
	$OptionsContainer.hide()
	$AddonContainer.show()


func _on_AddonContainer_back():
	$OptionsContainer.show()
