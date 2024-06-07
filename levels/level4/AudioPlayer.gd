extends Node

func play():
	for player in get_children():
		player.play()

func stop():
	for player in get_children():
		player.play()
