extends Spatial

export (PackedScene) var wall
export (PackedScene) var spike

enum tps {SPIKE,
		WALL,
		TRAMPOLINESPAWN,
		CIRCLESPAWN,
		FINISHPOS,
		BTS,
		STS}

class Tile:
	extends Node
	var type = 0
	var rot = 0
	var pos = Vector2()
	var obj3d = StaticBody

	func _init(tp, _pos, _rot, layer):
		var shape = BoxShape.new()
		shape.extends = Vector3(50, 50, 50)
		self.type = tp
		self.rot = _rot
		self.pos = _pos
		if tp < tps.TRAMPOLINESPAWN:
			self.obj3d = [self.get_parent().spike, self.get_parent().wall][tp].instance()
			self.obj3d.position = Vector3(0, self.pos.y, self.pos.x)
			self.obj3d.collision_layer = layer

	func get_obj():
		return self.obj3d

var tiles = {}
var drawn_tiles = []
export (int) var layer = 0

func _ready():
	hide()

func add_tile(pos:Vector2, type:int, rot:int):
	tiles[pos] = Tile.new(type, pos, rot, layer)
	visible = true
	visible = false


func _on_Tileset3d2d_visibility_changed():
	if visible:
		if not drawn_tiles or len(drawn_tiles) != len(tiles.keys()):
			drawn_tiles = []
			for tile in tiles.items():
				drawn_tiles.append(tile)
				add_child(tile.get_obj())
