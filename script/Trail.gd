extends TileMap

signal platform_generated

export var vel = 50

var xUp = 0
var yUp = 2

var xDown = 0
var yDown = 6

var cena

func _ready():
	randomize()
	set_process(true)
	cena = get_tree().get_current_scene()

func _process(delta):
		

	set_cellv(Vector2(xUp, yUp), tile_set.get_tiles_ids()[rand_range(1, 9)])
	
	
#
	if xUp == 10:
		emit_signal("platform_generated", map_to_world(Vector2(xUp, yUp)))

	
	set_cellv(Vector2(xDown, yDown), tile_set.get_tiles_ids()[rand_range(1, 9)])
	
	
	
	
	if get_cell(xUp, yUp) != INVALID_CELL:
		var count = 0
		for i in yUp:
			if i <= yUp:
				set_cellv(Vector2(xUp, count), tile_set.get_tiles_ids()[rand_range(1, 9)])
			i = i + 1
			count = count + 1
			
	if get_cell(xDown, yDown) != INVALID_CELL:
		var count = yDown
		count = count + 1
		var t = 11
		for i in yDown:
			if count <= t:
				set_cellv(Vector2(xDown, count), tile_set.get_tiles_ids()[rand_range(1, 9)])
				count = count + 1
			
			
	position = position - Vector2(vel * delta, 0)
	xUp = xUp + 1
	xDown = xDown + 1
	
	
#
#	if position.x  < -100:
#		get_cell_autotile_coord()
		
func calculate_bounds():
	var cell_bounds = get_used_rect()
	# create transform
	var cell_to_pixel = Transform2D(Vector2(cell_size.x * scale.x, 0), Vector2(0, cell_size.y * scale.y), Vector2())
	# apply transform
	return Rect2(cell_to_pixel * cell_bounds.position, cell_to_pixel * cell_bounds.size)
		
func _on_Timer_timeout():
	yUp = rand_range(0, 3)
	yDown = rand_range(6, 8)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		cena.kill()

