extends Control

enum ControllerType {XBOX, DUALSHOCK, SWITCH, TOUCH, KEYBOARD}
const JOYPAD_DEVICE_ID := 0
onready var new_pause_state = not get_tree().paused

onready var controller_hints = {
	"xbox": $Panel/ControllerHints/Xbox,
	"dualshock": $Panel/ControllerHints/DualShock,
	"switch": $Panel/ControllerHints/Switch,
	"keyboard": $Panel/ControllerHints/Keyboard
}

func _ready():
	visible = false
	if State.first_run:
		new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		
		
		
	activate_controller_hint()

	

func _input(event):		
	if event.is_action_pressed("pause"):
		new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		visible = new_pause_state
		
func activate_controller_hint() -> void:
	hide_controller_hint()
	show_controller_hint()
	yield(get_tree().create_timer(10.0), "timeout")
	
func hide_controller_hint() -> void:
	for device_hints in controller_hints.values():
		device_hints.hide()
		
func show_controller_hint() -> void:
	match get_controller_type():
		ControllerType.DUALSHOCK:
			controller_hints.dualshock.show()
		ControllerType.SWITCH:
			controller_hints.switch.show()
		ControllerType.XBOX:
			controller_hints.xbox.show()
		ControllerType.KEYBOARD:
			controller_hints.keyboard.show()
			
			
func get_controller_type() -> String:
	var joypads = Input.get_connected_joypads()

	if joypads.size() > 0:
		if Input.get_joy_name(JOYPAD_DEVICE_ID).matchn("*dualshock*"):
			return ControllerType.DUALSHOCK

		if Input.get_joy_name(JOYPAD_DEVICE_ID).matchn("*switch*"):
			return ControllerType.SWITCH

		return ControllerType.XBOX


	return ControllerType.KEYBOARD
	
