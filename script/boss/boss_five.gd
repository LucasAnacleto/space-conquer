extends KinematicBody2D

enum Directions {LEFT, RIGHT, NONE}

export var velocity = 15
export var gravity = 0

const SHOT_SCENE = preload("res://scenes/shots/shot_five.tscn")
onready var time = $Timer

const UP = Vector2(0, -1)
var direction = Directions.NONE
var motion = Vector2()

func _ready():
	set_process(true)
	
func _physics_process(_delta):
		motion.y += gravity
		
		match direction:
			Directions.RIGHT:
				motion.x = velocity
			Directions.LEFT:
				motion.x = -velocity
			Directions.NONE:
				motion.x = 0
				
		move_and_slide(motion, UP)
	
	
		if !time.autostart:
			#create_shot()
			restart_timer()
		

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
	
