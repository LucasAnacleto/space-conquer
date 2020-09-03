extends Node2D


var platform_generation_chunk_size = 5
var total_chunks_generated = 0

onready var player = $Player
onready var platform_generator = $PlatformGenerator
onready var map_chunk_width = int(get_viewport().size.x * platform_generation_chunk_size)


func _ready():
	platform_generator.generate_map(map_chunk_width)
	increment_total_chunks_generated()


func _process(_delta):	
	var player_position = player.position
	var viewport_size = get_viewport().size

	if player_position.x / viewport_size.x > total_chunks_generated - 2:
		platform_generator.generate_map(map_chunk_width)
		increment_total_chunks_generated()



func increment_total_chunks_generated() -> void:
	total_chunks_generated += platform_generation_chunk_size


func kill_Boss():
	pass


func _on_Player_player_died():
	yield(get_tree().create_timer(3.0), "timeout")
	get_tree().reload_current_scene()
