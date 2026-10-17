extends Node3D

func _ready() -> void:
	$XRButton.button_pressed.connect(pressed)

func pressed(btn):
	Globals.button_pressed.emit(self)
