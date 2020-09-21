extends Node

enum ControllerType {XBOX, DUALSHOCK, SWITCH, TOUCH, KEYBOARD}

const JOYPAD_DEVICE_ID := 0

func get_controller_type() -> String:
	var joypads = Input.get_connected_joypads()

	if joypads.size() > 0:
		var joy_name = Input.get_joy_name(JOYPAD_DEVICE_ID)
		if joy_name.matchn("*dualshock*"):
			return ControllerType.DUALSHOCK

		if joy_name.matchn("*switch*"):
			return ControllerType.SWITCH

		return ControllerType.XBOX

	if OS.has_touchscreen_ui_hint():
		return ControllerType.TOUCH

	return ControllerType.KEYBOARD
