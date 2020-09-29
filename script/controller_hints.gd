extends VBoxContainer


onready var _hints = {
	"xbox": $Xbox,
	"dualshock": $DualShock,
	"switch": $Switch,
	"keyboard": $Keyboard,
	"touch": $Touch,
}


func _ready():
	_hide_controller_hint()
	_show_controller_hint()

# warning-ignore:return_value_discarded
	Input.connect("joy_connection_changed", self, "_on_Input_joy_connection_changed")


func _hide_controller_hint() -> void:
	for device__hints in _hints.values():
		device__hints.hide()


func _show_controller_hint() -> void:
	match Global.get_controller_type():
		Global.ControllerType.DUALSHOCK:
			_hints.dualshock.show()
		Global.ControllerType.SWITCH:
			_hints.switch.show()
		Global.ControllerType.XBOX:
			_hints.xbox.show()
		Global.ControllerType.TOUCH:
			_hints.touch.show()
		Global.ControllerType.KEYBOARD:
			_hints.keyboard.show()


func _on_Input_joy_connection_changed(_device, _connected) -> void:
	_hide_controller_hint()
	_show_controller_hint()
