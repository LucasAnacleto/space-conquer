extends TileMap

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
	
	
func _on_Timer_timeout():
	yUp = rand_range(0, 3)
	yDown = rand_range(6, 8)


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		cena.kill()


func _on_TimerReload_timeout():
	get_tree().reload_current_scene()
