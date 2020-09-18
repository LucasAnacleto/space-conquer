extends Control

const CREDITS_PRESENT_TIME := 5.0

onready var credits = {
	"visual": $Panel/Credits/Visual,
	"audio": $Panel/Credits/Audio,
	"dev": $Panel/Credits/Dev,
	"special_thanks": $Panel/Credits/SpecialThanks
}


func _ready():
	if State.cred:
		present_credits()
		State.cred = false
	else:
		hide_credits()
		
	
func _process(_delta):
	if Input.is_action_pressed("pause"):
		queue_free()

func present_credits() -> void:
	hide_credits()
	credits.visual.show()
	yield(get_tree().create_timer(CREDITS_PRESENT_TIME), "timeout")
	credits.visual.hide()
	credits.audio.show()
	print(CREDITS_PRESENT_TIME)
	yield(get_tree().create_timer(CREDITS_PRESENT_TIME), "timeout")
	credits.audio.hide()
	credits.dev.show()
	yield(get_tree().create_timer(CREDITS_PRESENT_TIME), "timeout")
	credits.dev.hide()
	credits.special_thanks.show()
	yield(get_tree().create_timer(CREDITS_PRESENT_TIME), "timeout")
	credits.special_thanks.hide()
	
	
func hide_credits() -> void:
	for job in credits.values():
		job.hide()

func _on_Button_pressed():
	queue_free()
