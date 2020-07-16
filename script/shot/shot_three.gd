extends Area2D

const SHOT_SPEED = -200

func _ready():
	set_process(true)
	
	
func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * SHOT_SPEED
	position = position + motion * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
