extends RigidBody2D


signal player_died


const SHOT_SCENE = preload("res://scenes/shots/shot_player/shot_player.tscn")
const SHOOT_COOLDOWN = 0.5

var is_dead = false
var can_shoot = true
var impulse_offset = Vector2(0, 0)
var impulse = Vector2(8, -80)

onready var sprite = $AnimatedSprite
onready var gun = $Gun


func _physics_process(delta):
	if get_colliding_bodies().size() > 0:
		die()


func _input(event):
	if not is_dead:
		if event.is_action_pressed("Controlle"):
			jump()
		else:
			sprite.play('idle')

		if event.is_action_pressed("shot"):
			if can_shoot:
				shoot()


func jump():
	mode = RigidBody2D.MODE_RIGID
	sprite.play('jump')
	apply_impulse(impulse_offset, impulse)


func die():
	if State.first_run:
		State.first_run = false
	is_dead = true
	sprite.play("dead")
	emit_signal("player_died")


func shoot():
	var bullet = SHOT_SCENE.instance()
	bullet.position = gun.global_position
	get_parent().add_child(bullet)

	can_shoot = false
	yield(get_tree().create_timer(SHOOT_COOLDOWN), "timeout")
	can_shoot = true

