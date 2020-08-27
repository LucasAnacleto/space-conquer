extends Node

var enemyscene = load('res://scenes/NaveBoss/Ovni.tscn')
var rand = RandomNumberGenerator.new()
var screen_size
onready var test = $map/TileMap
var enemy 

func _process(delta):
	screen_size = get_viewport().get_visible_rect().size
	
#	if enemy != null:
#		enemy.position = enemy.position * delta
	
	
	
	
	
	
	
	
func spawn(last_cell_position: Vector2):	
	for i in range(0,1):
		enemy = enemyscene.instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		
		if test.get_cell(last_cell_position.x, last_cell_position.y) == test.INVALID_CELL:
			enemy.position.y = last_cell_position.y + y
			enemy.position.x = last_cell_position.x + x
			test.add_child(enemy)
 



func _on_TileMap_platform_generated(last_cell_position: Vector2):
	spawn(last_cell_position)
