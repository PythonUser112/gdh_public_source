extends KinematicBody2D

onready var sprite = $Sprite

signal pos
signal dead
signal progress
signal finished

export (int) var gravity
export (int) var fly_speed
export (int) var move_speed
var skin = PlayerControl.skins["Ship"]

var x_factor = 1
var y_factor = 4
var velocity = Vector2(400, 0)
var jump = false
var grotation = 0
var oyf = y_factor
var finish_x

func start():
	$Sprite.texture = Loader.nload("assets/playerskins/"+skin) as Texture
	$Sprite.visible = true
	set_process(true)
	position = Vector2()

func get_input():
	if Input.is_action_pressed("jump") or jump:
		velocity.y += fly_speed * y_factor
		jump = false
		y_factor = oyf

func _process(delta):
	velocity.y += gravity * delta * y_factor
	velocity.x += move_speed * delta * x_factor
	get_input()
	velocity = velocity.rotated(grotation)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name == "Danger":
			$Sprite.visible = false
			emit_signal("dead")
			set_process(false)
			return
			
	if velocity.x == 0:
		emit_signal("dead")
		$Sprite.visible = false
		set_process(false)
	if velocity.x > 400 * x_factor:
		velocity.x = 400 * x_factor
	emit_signal("progress", int(position.x/finish_x*100))
	emit_signal("pos", position)
	if position.x > finish_x:
		emit_signal("finished")
		set_process(false)

func _on_Main_start():
	start()

func _on_Item_entered(item):
	match item:
		"Jumping Board U":
			oyf = y_factor
			y_factor *= 1.75
			jump = true
		"Jumping Board D":
			oyf = y_factor
			y_factor *= 1.75
			jump = true
		"Jumping Board R":
			velocity.x = -x_factor*1.75*move_speed
		"Jumping Board L":
			velocity.x = x_factor*1.75*move_speed
			
func _on_Item_leaved(_item):
	pass

func _set_finish_pos(posx):
	finish_x = posx
