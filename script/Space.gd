extends Node2D

onready var p = $Player/AnimatedSprite
onready var pa = $Player
onready var tile = $Node/map/TileMap




var vel = 60

onready var timereplay = get_node("TimeReplay")

func _process(_delta):
	pass


	
func kill():
	p.play('dead')
	timereplay.start()
	pa.is_dead = false

func kill_Boss():
	pass
	


func _on_TimeReplay_timeout():
	tile.clear()
	get_tree().reload_current_scene()
