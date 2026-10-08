class_name DialogueManager
extends Node

signal cutscene_ended
signal next_line
var current_line_idx = 0
var dialogue_lines = []
var paused = false

func play():
	dialogue_lines = []
	for child in get_children():
		if child is Dialogue or child is DialogueManager:
			dialogue_lines.append(child)
	
	dialogue_lines[0].play()
	self.next_line.connect(on_line_end)
	

func on_line_end():
	if paused:
		return
		
	current_line_idx += 1
	if current_line_idx >= dialogue_lines.size():
		cutscene_ended.emit()
		self.next_line.disconnect(on_line_end)
		if get_parent() is DialogueManager:
			get_parent().next_line.emit()
		reset()
		print("Cutscene ended!")
		return
	dialogue_lines[current_line_idx].play()
	
func reset():
	dialogue_lines = []
	current_line_idx = 0
	
func pause():
	paused = true

func unpause(args):
	print("Unpaused!")
	paused = false
	on_line_end()
	
func play_next(dialogue_line):
	var c = get_children()
	for i in range(len(c)):
		if c[i] == dialogue_line:
			current_line_idx = i-1
