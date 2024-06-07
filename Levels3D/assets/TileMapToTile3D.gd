extends Node

func get_rotation(input:TileMap, cell_pos):
	var xflip = input.is_cell_x_flipped(cell_pos.x, cell_pos.y)
	var yflip = input.is_cell_y_flipped(cell_pos.x, cell_pos.y)
	var transposed = input.is_cell_transposed(cell_pos.x, cell_pos.y)
	var angle = -90
	if xflip:
		angle += 180
	if yflip:
		angle += 180
	if transposed:
		angle += 45
	return angle

func copy(input:TileMap, output):
	for element in input.get_used_cells():
		var id = input.get_cellv(element)
		var type = input.tile_set.tile_get_name(id)
		var pos = input.map_to_world(element) + input.cell_size / 2
		if not type in ["Wall.png", "Spike_big.png"]:
			continue
		var rot = get_rotation(input, element)
		output.add_tile(pos, {"Wall.png":1, "Spike_big.png":0}, rot)

func init():
	var env = get_parent().get_node("Ground")
	var danger = get_parent().get_node("Danger")
	var inenv:TileMap = get_parent().get_node("TileMaps/Ground")
	var indanger:TileMap = get_parent().get_node("TileMaps/Danger")
	copy(inenv, env)
	copy(indanger, danger)
