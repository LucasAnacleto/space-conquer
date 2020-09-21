extends RayCast2D


var is_casting := false setget set_is_casting
onready var line = $Line2D
onready var lasersom = $Audio/Firing


func _ready():
	self.is_casting = false
	line.visible = false
	pass

#func _unhandled_input(event) -> void:
#	if event is InputEventMouseButton:
#		self.is_casting = event.pressed

func _physics_process(_delta):
	var cast_point := cast_to
	force_raycast_update()

	$CollisionParticles2D.emitting = is_colliding()
	if is_colliding():
		cast_point = to_local(get_collision_point())
		$CollisionParticles2D.global_rotation = get_collision_normal().angle()
		$CollisionParticles2D.position = cast_point
		var body = get_collider()
		if body.has_method("die"):
			body.call("die")

	$Line2D.points[1] = cast_point
	$BeamParticles2D.position = cast_point * 0.5
	$BeamParticles2D.process_material.emission_box_extents.x = cast_point.length() * 0.5



func set_is_casting(cast: bool) -> void:
	is_casting = cast

	$BeamParticles2D.emitting = is_casting
	$CastingParticles2D.emitting = is_casting
	if is_casting:
		appear()
	else:
		$CollisionParticles2D.emitting = false
		disappaer()

	set_physics_process(is_casting)

func appear() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 0, 10.0, 0.2)
	$Tween.start()

func disappaer() -> void:
	$Tween.stop_all()
	$Tween.interpolate_property($Line2D, "width", 10.0, 0, 0.1)
	$Tween.start()

func _on_Player_player_laserbean(input):
	if input.is_action("shot"):
		if input.pressed:
			lasersom.play()

			if not self.is_casting:
				self.is_casting = input.pressed
				line.visible = true
		else:
			self.is_casting = false
