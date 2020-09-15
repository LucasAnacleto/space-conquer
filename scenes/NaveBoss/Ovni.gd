extends KinematicBody2D


export (int) var speed = 30

var target
var velocity = Vector2()
var is_dead = false

onready var sprite = $AnimatedSprite


func _physics_process(_delta):
	if target and not is_dead:
		velocity = position.direction_to(target.position) * speed

		if position.distance_to(target.position) > 5:
			velocity = move_and_slide(velocity)

func die():
	is_dead = true
	sprite.play("dead")
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()
	
	


func is_body_target(body) -> bool:
	return body.name == "Player"


func _on_FieldView_body_entered(body):
	if is_body_target(body):
		target = body


func _on_FieldView_body_exited(body):
	if is_body_target(body):
		target = null
