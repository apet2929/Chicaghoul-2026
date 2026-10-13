@tool
extends XRToolsPickable

var effect

var controller: XRController3D

func _ready():
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index("Record")
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)

func _process(delta: float) -> void:
	if self.is_picked_up():
		if controller == null:
			controller = XRHelpers.get_xr_controller(self)
		if controller != null:
			if controller.is_button_pressed("button"):
				_on_record_button_pressed()
				print("Record button pressed!")
				print("TODO: Play hand animation")

func _on_record_button_pressed():
	if effect.is_recording_active():
		var recording = effect.get_recording()
		$IndicatorLight.mode = IndicatorLight.Mode.OFF
		effect.set_recording_active(false)
		Globals.recording_finished.emit(recording)
		print("Finished recording!")
	else:
		$IndicatorLight.mode = IndicatorLight.Mode.ERROR
		effect.set_recording_active(true)
		print("Recording!")
