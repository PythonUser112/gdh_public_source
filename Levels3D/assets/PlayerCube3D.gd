extends KinematicBody

signal dead
signal progress
signal finished

export (int) var run_speed
export (int) var jump_speed
export (int) var gravity
export (int) var finish_x

var velocity = Vector3()

func _physics_process(delta):
	velocity.y += gravity
	velocity.x += run_speed
	print(velocity)
	if velocity.x*delta > 400:
		velocity.x = 400 / delta
	velocity = move_and_slide(velocity, Vector3(0, -1, 0))
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
	for idx in range(get_slide_count()):
		var collision = get_slide_collision(idx)
		if collision.collider.name == "Danger":
			emit_signal("dead")
	if velocity.x == 0:
		emit_signal("dead")
	emit_signal("progress", int(translation.x * 100 / finish_x))
	if translation.x >= finish_x:
		emit_signal("finished")
		set_process(false)
