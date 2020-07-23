extends Position2D

onready var boss_one = preload("res://scenes/boss/boss_one.tscn")
onready var boss_two = preload("res://scenes/boss/boss_two.tscn")
onready var boss_three = preload("res://scenes/boss/boss_three.tscn")
onready var boss_four = preload("res://scenes/boss/boss_four.tscn")
onready var boss_five = preload("res://scenes/boss/boss_five.tscn")
onready var boss_six = preload("res://scenes/boss/boss_six.tscn")


onready var Player = $RigidBody2D

var t
var boss
var positionPlayer

func _ready():
	set_process(true)
	
func _process(_delta):
	if boss != null:
		if Input.is_action_pressed("Controlle"):
			positionboss()
		else:
			positionboss()
			
func positionboss():
	positionPlayer = Player.global_position.y
	boss.position.y =  positionPlayer


func _on_Timer_timeout():
	if boss == null || t == "/root/Space/boss_six":
		if t == "/root/Space/boss_six":
			owner.remove_child(boss)
		boss = boss_one.instance()
		boss.position = position
		owner.add_child(boss)
		t = String(boss.get_path())
	elif t == "/root/Space/boss_one":	
		owner.remove_child(boss)
		boss = boss_two.instance()
		boss.position = position
		owner.add_child(boss)		
		t = String(boss.get_path())
	elif t == "/root/Space/boss_two":	
		owner.remove_child(boss)
		boss = boss_three.instance()
		boss.position = position
		owner.add_child(boss)		
		t = String(boss.get_path())
	elif t == "/root/Space/boss_three":	
		owner.remove_child(boss)
		boss = boss_four.instance()
		boss.position = position
		owner.add_child(boss)		
		t = String(boss.get_path())
	elif t == "/root/Space/boss_four":	
		owner.remove_child(boss)
		boss = boss_five.instance()
		boss.position = position
		owner.add_child(boss)		
		t = String(boss.get_path())
	elif t == "/root/Space/boss_five":
		owner.remove_child(boss)
		boss = boss_six.instance()
		boss.position = position
		owner.add_child(boss)		
		t = String(boss.get_path())	


