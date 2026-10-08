extends Node3D

func _ready() -> void:
	$XRButton.button_pressed.connect(pressed)

func pressed():
	Globals.button_pressed.emit(self)
