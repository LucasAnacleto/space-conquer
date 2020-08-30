extends RigidBody2D


signal player_died


const SHOT_SCENE = preload("res://scenes/shots/shot_player/shot_player.tscn")

var is_dead = false
var impulse_offset = Vector2(0, 0)
var impulse = Vector2(8, -80)

onready var anim = $AnimatedSprite
onready var time = $Timer


func _physics_process(delta):
	if get_colliding_bodies().size() > 0:
		die()


func _input(event):
	if not is_dead:
		if event.is_action_pressed("Controlle"):
			jump()
		else:
			anim.play('idle')

		if event.is_action_pressed("shot"):
			if !time.autostart:
				create_shot()
				restart_timer()


func jump():
	mode = RigidBody2D.MODE_RIGID
	anim.play('jump')
	apply_impulse(impulse_offset, impulse)


func die():
	is_dead = true
	anim.play("dead")
	emit_signal("player_died")


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
