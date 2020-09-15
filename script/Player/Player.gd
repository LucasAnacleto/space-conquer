extends RigidBody2D


signal player_died
signal player_laserbean



const SHOOT_COOLDOWN = 0.5

var is_dead = false
var can_shoot = true
var impulse_offset = Vector2(0, 0)
var impulse = Vector2(8, -80)

onready var sprite = $AnimatedSprite
onready var gun = $Gun
onready var light = $AnimatedSprite/Light2D
onready var laser = $LaserBeam2D

func _physics_process(delta):
	pass


func _input(event):
	if not is_dead:
		if event.is_action_pressed("Controlle"):
			jump()
		else:
			sprite.play('idle')		
			
		var cena = event
		if event.is_action_pressed("shot") or event is InputEventScreenTouch:			
			if can_shoot:				
				emit_signal("player_laserbean", cena)
				sprite.play('jump')
		else:
			emit_signal("player_laserbean", cena)

func jump():
	sprite.play('jump')	
	apply_impulse(impulse_offset, impulse)


func die():
	if State.first_run:
		State.first_run = false	
	is_dead = true
	mode = RigidBody2D.MODE_STATIC
	light.visible = false
	sprite.play("dead")
	emit_signal("player_died")
	laser.visible = false

func _on_Shot_pressed():
	if can_shoot:
		emit_signal("player_laserbean")
		sprite.play('jump')
	else:
		emit_signal("player_laserbean")


func _on_Iimpulse_pressed():
	if not is_dead && not get_tree().paused:
		jump()


func _on_Player_body_entered(body):
	if body.name != "Bullet":
		die()
