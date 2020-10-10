extends CanvasLayer


onready var touch_buttons = {
	"pause": $TouchButtons/Pause as TouchScreenButton,
	"shoot": $TouchButtons/Shoot as TouchScreenButton,
	"impulse": $TouchButtons/Impulse as TouchScreenButton,
}

onready var background := $Background as ColorRect
onready var touch_pause_button_anin := touch_buttons.pause.get_node("AnimatedSprite") as AnimatedSprite
onready var viewport_size := get_viewport().size
onready var controller_hints := $Hints/ControllerHints as VBoxContainer
onready var credits := $Hints/Credits as VBoxContainer


func _ready():
	controller_hints.show()
	toggle_screen_buttons()
	adjust_screen_buttons_size()
	set_ui_visibility(false)

	if State.first_run:
		credits.show()
	else:
		credits.hide()

# warning-ignore:return_value_discarded
	Input.connect("joy_connection_changed", self, "_on_Input_joy_connection_changed")


func set_ui_visibility(is_visible: bool) -> void:
	if is_visible:
		background.show()
		controller_hints.show()
		credits.show()
		touch_pause_button_anin.play("play")
	else:
		background.hide()
		controller_hints.hide()
		credits.hide()
		touch_pause_button_anin.play("stop")


func toggle_screen_buttons() -> void:
	for button in touch_buttons.values():
		button.visible = Global.get_controller_type() == Global.ControllerType.TOUCH


func adjust_screen_buttons_size() -> void:
	var half_screen_size_in_extents = Vector2(viewport_size.x / 2 / 2, viewport_size.y / 2)

	touch_buttons.pause.position = Vector2(viewport_size.x - touch_buttons.pause.shape.extents.x * 2, 0) - Vector2(8, -8)
	touch_buttons.shoot.position = Vector2(viewport_size.x / 2, 0)
	touch_buttons.impulse.position = Vector2(0, 0)
	touch_buttons.shoot.shape.extents = half_screen_size_in_extents
	touch_buttons.impulse.shape.extents = half_screen_size_in_extents


func _on_Input_joy_connection_changed(_device, _connected) -> void:
	toggle_screen_buttons()
