extends StaticBody2D

var dest1
var dest2
var id1
var id2
var movement
var dest

func init(size, _dest1, _dest2, _id1, _id2, _movement=200):
	var size2 = Vector2(size.x*50, size.y*50)
	$CollisionShape2D.shape.extents = size2
	$CollisionShape2D.position = size2-Vector2(50,50)
	dest1 = _dest1
	dest2 = _dest2
	id1 = _id1
	id2 = _id2
	movement = _movement
	
func distance(pos1, pos2):
	return sqrt(pow(pos2.x-pos1.x, 2)+pow(pos2.y-pos1.y, 2))

func _process(delta):
	if not dest:
		return
	var diff = dest - position
	if distance(position, dest) < movement * delta:
		position = dest
		dest = Vector2()
		constant_linear_velocity = Vector2(0, 0)
		return
	if position != dest:
		position += diff.normalized() * delta * movement
	var x = diff.normalized() * movement
	if constant_linear_velocity != x:
		constant_linear_velocity = x

func run(_id):
	if _id == id1:
		move_to(dest1)
	else:
		move_to(dest2)

func move_to(pos):
	dest = pos
