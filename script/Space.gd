extends Node2D

const SCORE_TEXT = "%sm"

var platform_generation_chunk_size = 5
var total_chunks_generated = 0

onready var player = $Player
onready var platform_generator = $PlatformGenerator
onready var map_chunk_width = int(get_viewport().size.x * platform_generation_chunk_size)
onready var ui = $UI
onready var score = $UI/ControlScore/Score

func _ready():
	platform_generator.generate_map(map_chunk_width)
	increment_total_chunks_generated()

	if State.first_run:
		pause_game()


func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

	if not player.is_dead and not get_tree().paused:
		score.text = SCORE_TEXT % State.set_score(int(player.position.x / 50.0))

	if player.position.x / get_viewport().size.x > total_chunks_generated - 2:
		platform_generator.generate_map(map_chunk_width)
		increment_total_chunks_generated()


func pause_game() -> void:
	get_tree().paused = !get_tree().paused
	ui.set_ui_visibility(get_tree().paused)


func increment_total_chunks_generated() -> void:
	total_chunks_generated += platform_generation_chunk_size


func _on_Player_player_died():
	$UI/Audio/Music.stop()
	yield(get_tree().create_timer(3.0), "timeout")
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
