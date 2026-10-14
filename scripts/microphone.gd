extends Node3D
var effect

@export var controller: XRController3D
var ax_button_pressed = false

func _ready():
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index("Record")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)

func _process(delta: float) -> void:
	if $Microphone.is_picked_up():
		if controller != null:
			if controller.is_button_pressed("ax_button"):
				ax_button_pressed = true
			else:
				if ax_button_pressed:
					ax_button_pressed = false
					# AX BUTTON RELEASE
					_on_record_button_pressed()
					print("Record button pressed!")
					print("TODO: Play hand animation")


func _on_record_button_pressed():
	if effect.is_recording_active():
		var recording = effect.get_recording()
		$Microphone/IndicatorLight.mode = IndicatorLight.Mode.OFF
		effect.set_recording_active(false)
		Globals.recording_finished.emit(recording)
		print("Finished recording!")
	else:
		$Microphone/IndicatorLight.mode = IndicatorLight.Mode.ERROR
		effect.set_recording_active(true)
		print("Recording!")
