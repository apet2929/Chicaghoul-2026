class_name Dialogue
extends Node

@export var subtitles: Array[String] = []
@export var durations: Array[float] = []
@export var source: AudioStreamPlayer # optional
@export var line_end_callbacks: Array[String] = []

func play():
	if source:
		source.play(0.0)
		
	for i in range(subtitles.size()):
		Globals.subtitle_inst.set_line(self.subtitles[i])
		await get_tree().create_timer(durations[i]).timeout
	
		if line_end_callbacks[i] != "":
			get_parent().call(line_end_callbacks[i])
	get_parent().next_line.emit()
	
