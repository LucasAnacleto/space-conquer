extends RigidBody2D

const SHOT_SCENE = preload("res://scenes/shots/shot_player/shot_player.tscn")
var is_dead = true
onready var anin = $AnimatedSprite2
onready var time = $Timer

func _process(_delta):
	set_process_input(true)
	if anin.animation == "New Anim":
		mode = RigidBody2D.MODE_STATIC

	

func _input(event):		
	if is_dead:
		if event.is_action_pressed("Controlle"):
			on_touch()
	elif anin.animation == "New Anim":
		mode = RigidBody2D.MODE_STATIC
		
	if event.is_action_pressed("shot"):
		if !time.autostart:
			create_shot()
			restart_timer()
		
func on_touch():
	mode = RigidBody2D.MODE_RIGID
	apply_impulse(Vector2(0, 0), Vector2(0, -300)) 
	
func create_shot():
	var shot = SHOT_SCENE.instance()
	get_parent().add_child(shot)
	shot.position = get_node("Position2D").global_position
	
func restart_timer():
	time.wait_time = .5
	time.autostart = true
	time.start()


func _on_Timer_timeout():
	time.autostart = false
