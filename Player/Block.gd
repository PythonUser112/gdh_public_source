extends KinematicBody2D

signal dead
signal finished
signal progress
signal pos

export (int) var gravity
export (int) var jump_speed
export (int) var move_speed
var skin = PlayerControl.skins["Block"]
onready var sprite = $Sprite
var finish_x = 0
var x_factor = 1
var y_factor = 4
var grotation = 0
var velocity = Vector2(400, 0)
var jump = false
var jump_allowed = false
var oyf = y_factor

func start():
	$Sprite.texture = Loader.nload("assets/playerskins/"+skin) as Texture
	$Sprite.visible = true
	set_process(true)
	position = Vector2()

func get_input():
	if ((Input.is_action_pressed("jump") and is_on_floor()) or\
	 (Input.is_action_just_pressed("jump") and jump_allowed)) or jump:
		if jump:
			velocity.y = 0
		velocity.y += jump_speed * y_factor
		jump_allowed = false
		jump = false
		y_factor = oyf


func _process(delta):
	var ovx = velocity.x
	if not is_on_floor():
		velocity.y += gravity * delta * y_factor
	velocity.x += move_speed * delta * x_factor
	get_input()
	velocity = velocity.rotated(grotation)
	velocity = move_and_slide(velocity, Vector2(0, -1))
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.collision_layer == 4:
			$Sprite.visible = false
			emit_signal("dead")
			set_process(false)
			return
			
	if velocity.x == 0 and ovx > 0 and x_factor != 0:
		emit_signal("dead")
		$Sprite.visible = false
		set_process(false)
	if velocity.x > 400 * x_factor:
		velocity.x = 400 * x_factor
	emit_signal("pos", position)
	emit_signal("progress", int(position.x/finish_x*100))
	if position.x > finish_x:
		emit_signal("finished")
		set_process(false)

func _on_Main_start():
	start()

func _on_Item_entered(item):
	match item:
		"Jumping Board U":
			oyf = y_factor
			if y_factor < 0:
				y_factor = -y_factor
			y_factor *= 1.75
			jump = true
		"Jumping Board D":
			oyf = y_factor
			if y_factor > 0:
				y_factor = -y_factor
			y_factor *= 1.75
			jump = true
		"Jumping Board R":
			velocity.x = -x_factor*1.75*move_speed
		"Jumping Board L":
			velocity.x = x_factor*1.75*move_speed
		"Circle":
			jump_allowed = true
			oyf = y_factor
			y_factor *= 1.75
			
func _on_Item_leaved(item):
	if item == "Circle":
		jump_allowed = false

func _set_finish_pos(posx):
	finish_x = posx
