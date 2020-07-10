extends Position2D


onready var test = preload("res://scenes/map/block.tscn")



func _ready():
	randomize()


func _on_Timer_timeout():
	var block = test.instance()
	block.position = position + Vector2(10, rand_range(-500, -100))
	owner.add_child(block)
