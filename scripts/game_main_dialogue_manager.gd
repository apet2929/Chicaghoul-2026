extends DialogueManager

@export var start_idx = 1 # Change to skip to a part of dialogue
var level: ShipLevel
func _ready():
	await get_tree().create_timer(0.5).timeout
	print("Playing dialogue!")
	if Globals.checkpoint_cur_dialogue_line != 0:
		start_idx = Globals.checkpoint_cur_dialogue_line
	self.current_line_idx = start_idx
	self.play()

func show_tutorial_ui():
	Globals.main_monitor_ui_inst.show_tutorial_ui()
	

func enter_alien():
	all_lights_flicker_hard()
	
func alien_lines_1():
	all_lights_flicker_hard()
	# TODO: If player unlocks cargo hold here, they should die

func wait_for_get_intercom():
	var intercom = get_tree().get_first_node_in_group("paper1")
	await intercom.picked_up
	print("Got intercom!")
	Globals.has_intercom = true
	unpause(null)

func wait_for_record_1():
	# Recording audio lure yell
	pass

func speed_check_lock_cockpit():
	# Lock the cockpit before time runs out or you die
	pass

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
	
func game_over():
	Globals.game_over.emit()
