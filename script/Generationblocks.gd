extends Position2D


onready var test = preload("res://scenes/map/block.tscn")



func _ready():
	randomize()


func _on_Timer_timeout():
	var block = test.instance()
	block.position = position + Vector2(0, rand_range(-200, 0))
	owner.add_child(block)
