extends Node2D


export var vel = -250

func _ready():
	set_process(true)
	
	
func _process(delta):
	position = position + Vector2(vel * delta, 0)
	
	if position.x < -250:
		print("destruido")
		queue_free()
