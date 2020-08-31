extends RigidBody2D

const SHOT_SPEED = 200
var cena

func _ready():
	cena = get_tree().get_current_scene()
	set_process(true)


func _process(delta):
	var speed_x = 1
	var speed_y = 0
	var motion = Vector2(speed_x, speed_y) * SHOT_SPEED
	position = position + motion * delta

	if get_colliding_bodies().size() > 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
