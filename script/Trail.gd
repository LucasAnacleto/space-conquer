extends Node2D


onready var tileMap  = $TileMapDown
export var vel = 400
var x_initup = 0

onready var tileMap2  = $TileMapUp
var x_initdown = 0
var y_initup = 50
var y_initdown = 13

var yUp = 50
var xUp = 0
	
var xdown = 0
var ydown = 13

var p
var o

var u
var k

var b

func _ready():
	randomize()
	set_process(true)

func _process(delta):
	
	if y_initup < yUp:
		o = int(y_initup)
		p = yUp - 1
		for yUp in o:
			if o < p && p > yUp:
				tileMap.set_cellv(Vector2(xUp, p), tileMap.tile_set.get_tiles_ids()[0])
			p = p - 1
	elif y_initup > yUp:
		var h = p
		for h in y_initup:
			if h > o && h > yUp:
				tileMap.set_cellv(Vector2(xUp, h), tileMap.tile_set.get_tiles_ids()[0])	
				
	if y_initdown < ydown:
		u = int(y_initdown)
		k = ydown - 1
		for ydown in u:
			if u < k && k >= ydown:
				tileMap2.set_cellv(Vector2(xdown, k), tileMap2.tile_set.get_tiles_ids()[0])
			k = k - 1
	elif y_initdown > ydown:
		b = k
		if b != null:
			for b in y_initdown:
				if b > u && b >= ydown:
					tileMap2.set_cellv(Vector2(xdown, b), tileMap2.tile_set.get_tiles_ids()[0])	
		else:
			u = int(y_initdown)
			k = ydown + 1
			b = k
			for b in y_initdown:
				tileMap2.set_cellv(Vector2(xdown, k), tileMap2.tile_set.get_tiles_ids()[0])	
			
			
	yUp = y_initup
	xUp = x_initup
	xdown = x_initdown
	ydown = y_initdown
	
	tileMap.set_cellv(Vector2(xUp, yUp), tileMap.tile_set.get_tiles_ids()[0])
	x_initup = x_initup + 1
	position = position - Vector2(vel * delta, 0)
	
	tileMap2.set_cellv(Vector2(xdown, ydown), tileMap2.tile_set.get_tiles_ids()[0])
	x_initdown = x_initdown + 1
	
	
func _on_Timer_timeout():
	y_initup = rand_range(50, 30)
	y_initdown = rand_range(6, 20)
