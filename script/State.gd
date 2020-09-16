extends Node

var score := 0
var total := 0
var first_run := true

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
func set_score(points: int) -> int:
	if first_run:
		first_run = false

	score = points + total
	return score

