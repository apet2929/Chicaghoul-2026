extends Node3D
class_name ButtonsContainer


@onready var submit_button = %SubmitButton
@onready var flight_controls_button = %FlightControlsButtons
@onready var escape_pod_passcode_button = %EscapePodPasscodeButtons
@onready var audio_lures_buttons = $AudioLureButtons
@onready var cargo_lock_button = $CargoLockButtons
@onready var cancel_order_button = %CancelOrderButton

func _ready() -> void:
	Globals.buttons_container = self
