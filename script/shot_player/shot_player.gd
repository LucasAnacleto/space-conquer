extends Area2D

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

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	if body.name == "boss_one":
		cena.kill_Boss()
	elif body.name == "boss_two":
		cena.kill_Boss()
	elif body.name == "boss_three":
		cena.kill_Boss()
	elif body.name == "boss_four":
		cena.kill_Boss()
	elif body.name == "boss_five":
		cena.kill_Boss()
	elif body.name == "boss_six":
		cena.kill_Boss()
