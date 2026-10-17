extends Node3D

var is_pressable = true
func _ready() -> void:
	$XRButton.button_pressed.connect(pressed)

func pressed(btn):
	if is_pressable:
		is_pressable = false
		Globals.button_pressed.emit(self)
		await get_tree().create_timer(0.5).timeout
		is_pressable = true
