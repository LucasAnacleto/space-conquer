extends RayCast2D

const initial = 0
const final = 10.0
const duration = 0.2
var is_casting := false setget set_is_casting

onready var line = $Line2D as Line2D
onready var laser_sound = $Audio/Firing as AudioStreamPlayer
onready var collision_particles = $CollisionParticles2D as Particles2D
onready var beam_particles = $BeamParticles2D as Particles2D
onready var casting_particles = $CastingParticles2D as Particles2D
onready var tween = $Tween as Tween


func _ready():
	self.is_casting = false
	line.visible = false

func firing(input):
	if input.is_action("shot"):
		if input.pressed:
			if not self.is_casting:
				self.is_casting = input.pressed
				line.visible = true
				laser_sound.play()
		else:
			self.is_casting = false

	

func _physics_process(_delta):
	var cast_point := cast_to
	force_raycast_update()

	collision_particles.emitting = is_colliding()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		collision_particles.global_rotation = get_collision_normal().angle()
		collision_particles.position = cast_point
		var body = get_collider()
		if body.has_method("die"):
			body.call("die")

	line.points[1] = cast_point
	beam_particles.position = cast_point * 0.5
	beam_particles.process_material.emission_box_extents.x = cast_point.length() * 0.5



func set_is_casting(cast: bool) -> void:
	is_casting = cast

	beam_particles.emitting = is_casting
	casting_particles.emitting = is_casting
	if is_casting:
		appear()
	else:
		collision_particles.emitting = false
		disappaer()

	set_physics_process(is_casting)

func appear() -> void:
	tween.stop_all()
	tween.interpolate_property(line, "width", initial, final, duration)
	tween.start()

func disappaer() -> void:
	tween.stop_all()
	tween.interpolate_property(line, "width", final, initial, duration)
	tween.start()
