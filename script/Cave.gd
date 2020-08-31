extends TileMap


signal platform_generated


var last_rendered_column: int

onready var total_vertical_cells := int(get_viewport().size.y / cell_size.y)


func _ready():
	randomize()


func get_random_tile() -> int:
	var tile_ids = tile_set.get_tiles_ids()

	return tile_ids[randi() % tile_ids.size()]


func _on_SpaceInTheMiddlePlatformGenerator_draw_section(section: Dictionary):
	var start_column = last_rendered_column

	if not last_rendered_column:
		start_column = section.units * section.index

	for part in section.parts:
		for x in range(start_column, start_column + part.size):
			var limit_top = part.top - total_vertical_cells
			var limit_bottom = part.bottom + total_vertical_cells

			for y in range(limit_top, part.top):
				set_cellv(Vector2(x, y), get_random_tile())

			for y in range(part.bottom, limit_bottom):
				set_cellv(Vector2(x, y), get_random_tile())

		var position_top = {
			"from": map_to_world(Vector2(start_column, part.top)),
			"to": map_to_world(Vector2(start_column + part.size, part.top))
		}

		var position_bottom = {
			"from": map_to_world(Vector2(start_column, part.bottom)),
			"to": map_to_world(Vector2(start_column + part.size, part.bottom))
		}

		emit_signal("platform_generated", section, part, position_top, position_bottom)

		start_column += part.size

	last_rendered_column = start_column
