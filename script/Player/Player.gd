extends RigidBody2D


signal player_died
signal player_laserbean



const SHOOT_COOLDOWN = 0.5

var is_dead = false
var can_shoot = true
var impulse_offset = Vector2(0, 0)
var impulse = Vector2(8, -80)

onready var sprite = $AnimatedSprite
onready var light = $AnimatedSprite/Light2D
onready var laser = $LaserBeam2D
onready var lase = $LaserBeam2D/Audio/Firing

func _physics_process(_delta):
	if get_colliding_bodies().size() > 0:
		die()



func _input(event):
	if not is_dead:
		if event.is_action_pressed("Controlle"):
			jump()
			$Audio/Jump.play()
			$Audio/Jump.volume_db = -15
		else:
			sprite.play('idle')

		var cena = event
		if event.is_action_pressed("shot"):
			emit_signal("player_laserbean", cena)
			sprite.play('jump')
			lase.playing = true
			lase.volume_db = -10
		else:
			emit_signal("player_laserbean", cena)

func jump():
	sprite.play('jump')
	apply_impulse(impulse_offset, impulse)


func die():
	if not is_dead:
		$Audio/dead.play()
		State.first_run = false
		is_dead = true
		mode = RigidBody2D.MODE_STATIC
		light.visible = false
		sprite.play("dead")

	emit_signal("player_died")
	laser.visible = false
