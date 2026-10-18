class_name Dialogue
extends Node

@export var subtitles: Array[String] = []
@export var durations: Array[float] = []
@export var source: AudioStream # optional
@export var line_end_callbacks: Array[String] = []
var audio_listener: AudioStreamPlayer3D # set by parent

func _ready() -> void:
	if subtitles.size() != durations.size() || subtitles.size() != line_end_callbacks.size():
		push_error(str(self.get_path()) + "invalid arrays!")

func play():
	print_debug(str(self.get_path()) + " playing!")
	if source:
		audio_listener.stream = source
		audio_listener.play(0.0)
	
	for i in range(subtitles.size()):
		Globals.subtitle_inst.set_line(self.subtitles[i])
		await get_tree().create_timer(durations[i]).timeout
	
		if line_end_callbacks[i] != "":
			get_parent().call(line_end_callbacks[i])
	get_parent().next_line.emit()
	
