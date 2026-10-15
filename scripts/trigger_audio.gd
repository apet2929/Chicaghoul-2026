extends Node3D

@export var trigger_signal_name: String # name of signal in parent that will be emitted when audio effect is to be played
@export var sfx: AudioStream

func _ready() -> void:
	get_parent().connect(trigger_signal_name, on_trigger_emitted)
	var randomizer_stream: AudioStreamRandomizer = $AudioStreamPlayer3D.stream
	randomizer_stream.add_stream(0, sfx)

func on_trigger_emitted(..._args):
	$AudioStreamPlayer3D.play()
	
