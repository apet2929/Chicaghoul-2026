extends DialogueManager

@export var start_idx = 1 # Change to skip to a part of dialogue
var level: ShipLevel
func _ready():
	await get_tree().create_timer(0.5).timeout
	print("Playing dialogue!")
	self.current_line_idx = start_idx
	self.play()

func show_tutorial_ui():
	Globals.main_monitor_ui_inst.show_tutorial_ui()
	

func enter_alien():
	all_lights_flicker_hard()
	

func all_lights_flicker(flicker_rate):
	$Level/Environment.all_lights_flicker(flicker_rate)


func all_lights_flicker_hard():
	$Level/Environment.all_lights_flicker(1.09)

func all_lights_flicker_medium():
	$Level/Environment.all_lights_flicker(1.04)
	
func all_lights_flicker_none():
	$Level/Environment.all_lights_flicker(0.5)

func play_sfx(node: AudioStreamPlayer, name):
	node.play(name)
