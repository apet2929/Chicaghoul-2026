extends Node3D
class_name ButtonsContainer


@onready var submit_button = %SubmitButton
@onready var flight_controls_button = %FlightControlsButtons
@onready var escape_pod_passcode_button = %EscapePodPasscodeButtons
@onready var cargo_lock_button = %CargoBayDoorLockButton
@onready var lock_door_buttons = %LockButtons
@onready var lure_door_buttons = %LureButtons

func _ready() -> void:
	Globals.buttons_container = self
