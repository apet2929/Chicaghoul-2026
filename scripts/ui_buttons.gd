extends Node3D
class_name UIButtons

@onready var left_button = $LeftButton
@onready var right_button = $RightButton
@onready var up_button = $UpButton
@onready var down_button = $DownButton
@onready var buttons = [$LeftButton, $RightButton, $UpButton, $DownButton]

signal on_button_pressed(button)

func _ready() -> void:
	for button in buttons:
		button.on_pressed.connect(self.emit_pressed, ConnectFlags.CONNECT_APPEND_SOURCE_OBJECT)

func emit_pressed(button):
	self.on_button_pressed.emit(button)
