extends Area2D

onready var boss_one = preload("res://scenes/boss/boss_one.tscn").instance()
onready var boss_two = preload("res://scenes/boss/boss_two.tscn")
onready var boss_three = preload("res://scenes/boss/boss_three.tscn")
onready var boss_four = preload("res://scenes/boss/boss_four.tscn")
onready var boss_five = preload("res://scenes/boss/boss_five.tscn")
onready var boss_six = preload("res://scenes/boss/boss_six.tscn")


#onready var Player = $Player

var t
var boss
var positionPlayer
var pos

func _ready():
	set_process(true)
	
func _physics_process(_delta):
	
	pos = getposiotion()	
	if boss != null:
		if Input.is_action_pressed("controlle"):			
			positionboss(pos)
		else:
			positionboss(pos)
			
func getposiotion() -> float:
	pos = get_parent().get_node("naveplayer")
	if pos == null:
		pos = Vector2(0,0)
		return pos
	else:
		var posGlobal = pos.global_position
		return posGlobal	
			
func positionboss(argu):
	boss.position.y =  argu.y


func _on_Timer_timeout():
	if boss == null || t == "/root/Space/boss_six":
		if t == "/root/Space/boss_six":
			owner.remove_child(boss)
		boss = boss_one
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


