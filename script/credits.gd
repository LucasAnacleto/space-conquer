extends VBoxContainer

var current_credit := 1

onready var credits := get_children()
onready var title := credits[0] as MarginContainer


func _ready():
	present_credits()


func present_credits() -> void:
	hide_credits()
	title.show()
	while current_credit < credits.size():
		credits[current_credit].show()
		yield(get_tree().create_timer(3.0), "timeout")
		credits[current_credit].hide()
		current_credit += 1
	title.hide()


func hide_credits() -> void:
	current_credit = 1

	for job in credits:
		job.hide()
