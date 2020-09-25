extends RigidBody2D


signal player_died
signal player_laserbean

var is_dead := false
var impulse_offset := Vector2(0, 0)
var impulse := Vector2(8, -80)

onready var jump_sound := $Audio/Jump as AudioStreamPlayer
onready var death_sound := $Audio/dead as AudioStreamPlayer
onready var sprite := $AnimatedSprite as AnimatedSprite
onready var helmet_light := $AnimatedSprite/HelmetLight as Light2D
onready var laser := $LaserBeam2D as RayCast2D
onready var laser_firing_sound := $LaserBeam2D/Audio/Firing as AudioStreamPlayer


func _physics_process(_delta):
	if get_colliding_bodies().size() > 0:
		if not is_dead:
			sprite.play("dead")
			death_sound.play()
			is_dead = true
			helmet_light.visible = false
			laser.visible = false

			emit_signal("player_died")

	if not is_dead:
		if Input.is_action_pressed("control") or Input.is_action_pressed("shot"):
			sprite.play('jump')
		else:
			sprite.play('idle')


func _input(event):
	if not is_dead:
		if event.is_action_pressed("control"):
			jump_sound.play()
			apply_impulse(impulse_offset, impulse)

		if event.is_action_pressed("shoot"):
			laser.firing(event)
		else:
			laser.firing(event)
