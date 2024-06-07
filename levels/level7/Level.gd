extends Node2D

signal finish_pos

var act_scale = 0
var height = 0
var state = 0
var ud = 1
var x = true
var up = false
onready var vault_3d = $Vault/Viewport/Vault

func init():
	emit_signal("finish_pos", pow(2, 64)-1)
	return [[], []]


func _on_Timer_timeout():
	match(state):
		0:
			$Timer.wait_time = 0.05
			state = 1
		1:
			act_scale += 0.05
			if act_scale > 1:
				state = 2
				$MoveTween.interpolate_property($MoveLayer/Sprite, "position",
				null, Vector2(500, 100), 3,
				Tween.TRANS_LINEAR, Tween.EASE_OUT)
				$MoveTween.start()
				$Timer2.wait_time = 10
				$Timer2.start()
			else:
				$MoveLayer/Sprite.scale = Vector2(1, 1) * act_scale
		2:
			$MoveLayer/Sprite.rotate(0.1)
		3:
			$MoveLayer/Sprite.modulate.a8 -= 1
			$MoveLayer/ColorRect.color.a8 -= 1
			if $MoveLayer/ColorRect.color.a8 <= 0.5:
				$MoveLayer/ColorRect.hide()
				$MoveLayer/Sprite.hide()
				state = 4
				$Vault/Viewport/Vault/Camera.current = true
	if state != 4:
		$Timer.start()


func _on_Timer2_timeout():
	if x:
		x = false
		return
	state = 3


func _on_MoveTween_tween_completed(_object, _key):
	if state != 3:
		up = not up
		if up:
			$MoveTween.interpolate_property($MoveLayer/Sprite, "position",
			null, Vector2(500, 100), 3,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
		else:
			$MoveTween.interpolate_property($MoveLayer/Sprite, "position",
			null, Vector2(500, 300), 3,
			Tween.TRANS_LINEAR, Tween.EASE_IN)
		$MoveTween.start()
