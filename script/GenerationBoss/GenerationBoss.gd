extends Node

var enemyscene = load('res://scenes/NaveBoss/Ovni.tscn')
var rand = RandomNumberGenerator.new()
var screen_size

func _ready():
	screen_size = get_viewport().get_visible_rect().size
	
	
	
	
	
	
	
func spawn():
	for i in range(0,3):
		var enemy = enemyscene.instance()
		rand.randomize()
		var x = rand.randf_range(0, screen_size.x)
		rand.randomize()
		var y = rand.randf_range(0, screen_size.y)
		enemy.position.y = y
		enemy.position.x = x
		add_child(enemy)
 

