extends Node2D


export var vel = -400

func _ready():
	set_process(true)
	
	
func _process(delta):
	position = position + Vector2(vel * delta, 0)
	
	if position.x < -100:
		print("destruido")
		queue_free()
