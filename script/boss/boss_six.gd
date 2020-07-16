extends KinematicBody2D

const SHOT_SCENE = preload("res://scenes/shots/shot_six.tscn")
onready var time = $Timer

func _ready():
	set_process(true)
	
func _process(_delta):
		if !time.autostart:
			create_shot()
			restart_timer()
		

func create_shot():
	var shot = SHOT_SCENE.instance()
	get_parent().add_child(shot)
	shot.position = get_node("Position2D").global_position
	
func restart_timer():
	time.wait_time = .4
	time.autostart = true
	time.start()


func _on_Timer_timeout():
	time.autostart = false
	
