extends AudioStreamPlayer3D

func _ready() -> void:
	Globals.recording_finished.connect(record_finished)
	#self.play()
	
func record_finished(stream: AudioStreamWAV):
	var mic = get_tree().get_first_node_in_group("microphone")
	self.stream = mic.get_parent().get_parent().recording
	self.play()
