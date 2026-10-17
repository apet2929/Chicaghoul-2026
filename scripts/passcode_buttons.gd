extends Node3D
class_name PasscodeButtons

const LEFT = "l"
const RIGHT = "r"
const UP = "u"
const DOWN = "d"
@export var correct_passphrase = "lurdu"
var current_input = ""

@onready var left_button = $LeftButton
@onready var right_button = $RightButton
@onready var up_button = $UpButton
@onready var down_button = $DownButton
@onready var buttons = [$LeftButton, $RightButton, $UpButton, $DownButton]
signal on_button_pressed(button)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	left_button.on_pressed.connect(button_pressed, ConnectFlags.CONNECT_APPEND_SOURCE_OBJECT)
	right_button.on_pressed.connect(button_pressed, ConnectFlags.CONNECT_APPEND_SOURCE_OBJECT)
	up_button.on_pressed.connect(button_pressed, ConnectFlags.CONNECT_APPEND_SOURCE_OBJECT)
	down_button.on_pressed.connect(button_pressed, ConnectFlags.CONNECT_APPEND_SOURCE_OBJECT)
	#Globals.submit_button_pressed.connect(self.submit_pressed)

func button_pressed(button):
	self.on_button_pressed.emit(button)
	if button == left_button:
		current_input += LEFT
	if button == right_button:
		current_input += RIGHT
	if button == up_button:
		current_input += UP
	if button == down_button:
		current_input += DOWN
	
	#print(str(button) + " pressed, current_input is now " + str(current_input))
	Globals.passcode_states[self.name] = current_input
	if current_input.length() >= correct_passphrase.length():
		check_passphrase()
	else:
		Globals.passphrase_updated.emit(self.name)

func submit_pressed():
	check_passphrase()

func check_passphrase():
	if current_input == correct_passphrase:
		Globals.passphrase_correct.emit(self)
	else:
		Globals.passphrase_incorrect.emit(self)
	current_input = ""
