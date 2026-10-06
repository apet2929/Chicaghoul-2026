class_name Dialogue
extends Node

@export var subtitle: String = ""
@export var duration: float = 0.0
@export var source: AudioStreamPlayer # optional
@export var on_end_callback_fn_name: String = ""

func play():
	if source:
		source.play(0.0)
	Globals.subtitle_inst.set_line(self.subtitle)
	
	await get_tree().create_timer(duration).timeout
	if on_end_callback_fn_name != "":
		get_parent().call(on_end_callback_fn_name)
	get_parent().next_line.emit()
	
