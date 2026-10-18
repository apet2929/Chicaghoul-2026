extends "res://scripts/passcode_button.gd"

@export var location_ref: Node3D

func _on_pressed(_arg):
	super._on_pressed(_arg)
	Globals.lure_played.emit(location_ref)
