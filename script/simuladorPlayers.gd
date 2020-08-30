extends RigidBody2D



func _ready():
	set_process_input(true)


func _input(event):
	if event.is_action_pressed("Controlle"):
		on_touch()


func on_touch():
	apply_impulse(Vector2(0, 0), Vector2(0, -500))
