class_name DialogueManager
extends Node

signal cutscene_ended
signal next_line
var current_line_idx = 0
var dialogue_lines = []
func play():
	dialogue_lines = []
	for child in get_children():
		if child is Dialogue:
			dialogue_lines.append(child)
	
	dialogue_lines[0].play()
	self.next_line.connect(on_line_end)
	

func on_line_end():
	current_line_idx += 1
	if current_line_idx >= dialogue_lines.size():
		cutscene_ended.emit()
		dialogue_lines = []
		print("Cutscene ended!")
		return
		
	dialogue_lines[current_line_idx].play()
	
