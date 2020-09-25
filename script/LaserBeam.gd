extends RayCast2D


export var cast_speed := 7000.0
export var max_length := 1400
export var growth_time := 0.1


onready var fill = $FillLine2D as Line2D
onready var laser_sound = $Audio/Firing as AudioStreamPlayer
onready var collision_particles = $CollisionParticles2D as Particles2D
onready var beam_particles = $BeamParticles2D as Particles2D
onready var casting_particles = $CastingParticles2D as Particles2D
onready var tween = $Tween as Tween
onready var line_width: float = fill.width


var is_casting := false setget set_is_casting


func _ready():
	set_physics_process(false)
	fill.points[1] = Vector2.ZERO

func firing(input):
	if input.is_action("shoot"):
		if input.pressed:
			if not self.is_casting:
				self.is_casting = input.pressed
				laser_sound.play()
		else:
			self.is_casting = false

	

func _physics_process(delta):
	cast_to = (cast_to + Vector2.RIGHT * cast_speed * delta).clamped(max_length)
	cast_beam()
	
	
	
func cast_beam():
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

	fill.points[1] = cast_point
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
	tween.interpolate_property(fill, "width", 0, line_width, growth_time * 2)
	tween.start()

func disappaer() -> void:
	tween.stop_all()
	tween.interpolate_property(fill, "width", fill.width, 0, growth_time)
	tween.start()
