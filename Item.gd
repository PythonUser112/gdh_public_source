extends Area2D

signal activated
signal deactivated

var objects =  {"Circle": "res://assets/objects/Circle.png",
				"Jumping Board U": "res://assets/objects/Jumpin-Bord.png",
				"Jumping Board O": "res://assets/objects/Jumpin-Bord_O.png",
				"Jumping Board L": "res://assets/objects/Jumpin-Bord_L.png",
				"Jumping Board R":"res://assets/objects/Jumpin-Bord_R.png"}
var itemtype

func init(shape):
	$Sprite.texture = load(objects[shape])
	itemtype = shape


func _on_Item_body_entered(__):
	emit_signal("activated", itemtype)


func _on_Item_body_exited(__):
	emit_signal("deactivated", itemtype)
