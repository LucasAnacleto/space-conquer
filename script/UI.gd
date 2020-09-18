extends CanvasLayer


enum ControllerType {XBOX, DUALSHOCK, SWITCH, TOUCH, KEYBOARD}
const JOYPAD_DEVICE_ID := 0
onready var new_pause_state = not get_tree().paused

onready var control = $Control
onready var sounds = $Audio/Music
var new_creditos

onready var creditos = preload("res://scenes/Creditos.tscn")

onready var controller_hints = {
	"xbox": $Control/Panel/ControllerHints/Xbox,
	"dualshock": $Control/Panel/ControllerHints/DualShock,
	"switch": $Control/Panel/ControllerHints/Switch,
	"keyboard": $Control/Panel/ControllerHints/Keyboard,
	"touch": $Control/Panel/ControllerHints/Touch
}

onready var touch_pause_button = $Pause
onready var touch_pause_button_anin = $Pause/AnimatedSprite


func _ready():
	control.visible = false
	if State.first_run:
		new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		control.visible = new_pause_state
		
	if not State.first_run:
		$Audio/Music.play()
		
	if get_tree().paused:
		touch_pause_button_anin.play("play")
		
	activate_controller_hint()
	show_screen_buttons()
	
	
	Input.connect("joy_connection_changed", self, "_on_Input_joy_connection_changed")

	

func _input(event):
	if event.is_action_pressed("pause"):
		new_pause_state = not get_tree().paused
		get_tree().paused = new_pause_state
		control.visible = new_pause_state
		touch_pause_button_anin.play('play')
		if new_pause_state:
			$Audio/Music.stream_paused = true			
		else:
			if not $Audio/Music.playing and State.first_run:
				$Audio/Music.playing = true
				$Audio/Music.volume_db = -5
				$Audio/Music.stream_paused = false
	if not get_tree().paused:
		touch_pause_button_anin.play('stop')
		
		
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
		ControllerType.TOUCH:
			controller_hints.touch.show()
		ControllerType.KEYBOARD:
			controller_hints.keyboard.show()
			
func show_screen_buttons() -> void:
	if get_controller_type() == ControllerType.TOUCH:
		touch_pause_button.show()
	else:
		touch_pause_button.hide()
			
func get_controller_type() -> String:
	var joypads = Input.get_connected_joypads()

	if joypads.size() > 0:
		if Input.get_joy_name(JOYPAD_DEVICE_ID).matchn("*dualshock*"):
			return ControllerType.DUALSHOCK

		if Input.get_joy_name(JOYPAD_DEVICE_ID).matchn("*switch*"):
			return ControllerType.SWITCH

		return ControllerType.XBOX

	if OS.has_touchscreen_ui_hint():
		return ControllerType.TOUCH

	return ControllerType.KEYBOARD
	
func _on_Input_joy_connection_changed(_device, _connected) -> void:
	activate_controller_hint()
	show_screen_buttons()


func _on_Button_pressed():
	new_creditos = creditos.instance()
	add_child(new_creditos)
