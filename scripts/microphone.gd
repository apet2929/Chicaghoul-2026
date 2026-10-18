extends Node3D
var effect: AudioEffectRecord

@export var controller: XRController3D
var ax_button_pressed = false
var recording

func _ready():
	# We get the index of the "Record" bus.
	var idx = AudioServer.get_bus_index(&"Record")
	#AudioServer.get_bus_peak_volume_left_db(idx, 0)
	# And use it to retrieve its first effect, which has been defined
	# as an "AudioEffectRecord" resource.
	effect = AudioServer.get_bus_effect(idx, 0)

func _process(delta: float) -> void:
	if $SnapZone/Microphone.is_picked_up():
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
		recording = effect.get_recording()
		$SnapZone/Microphone/IndicatorLight.mode = IndicatorLight.Mode.OFF
		effect.set_recording_active(false)
		recording.set_mix_rate(44100)
		recording.set_format(AudioStreamWAV.FORMAT_16_BITS)
		recording.set_stereo(true)
		recording.save_to_wav("user://record.wav")
		Globals.recording_finished.emit(recording)
		
		print("Finished recording!")
	else:
		$SnapZone/Microphone/IndicatorLight.mode = IndicatorLight.Mode.ERROR
		effect.set_recording_active(true)
		print("Recording!")


func _on_microphone_dropped(pickable: XRToolsPickable) -> void:
	$SnapZone.pick_up_object($SnapZone/Microphone)
