extends DialogueManager


func enter_alien():
	all_lights_flicker_hard()
	var alien: Alien = get_tree().get_first_node_in_group("alien")
	%AllenScream.play()
	alien.current_location = Alien.LOC_FOYER
	alien.move()
	
func _ready() -> void:
	await get_tree().create_timer(2).timeout
	enter_alien()

func play_alarm():
	Globals.ambience_manager.play_alarm()

func enter_alien_end():
	%Environment.reset_flicker()

func alien_lines_1():
	all_lights_flicker_hard()
	# TODO: If player unlocks cargo hold here, they should die

func wait_for_get_intercom():
	var intercom = get_tree().get_first_node_in_group("microphone")
	pause()
	await intercom.picked_up
	print("Got intercom!")
	Globals.has_intercom = true
	unpause(null)
	
func kill_if_unlock_cockpit():
	var btn:  = Globals.buttons_container.lock_door_buttons.get_child(0)
	assert(btn.name == "CockpitDoorLockButton")
	btn.on_pressed.connect(kill)
	
	
func reset_killcheck():
	var btn:  = Globals.buttons_container.lock_door_buttons.get_child(0)
	btn.on_pressed.disconnect(kill)
	Globals.ambience_manager.stop_alarm()
	
func kill():
	var game: Game = get_tree().get_first_node_in_group("game_root")
	game.game_over()

func wait_for_record():
	# Recording audio lure yell
	pause()
	await Globals.recording_finished
	print("Recording finished!")
	unpause(null)

func wait_for_press_engine_room_audio_lure():
	var btn = Globals.buttons_container.lure_door_buttons.get_child(1)
	assert(btn.name == "EngineRoomDoorLureButton")
	btn.on_pressed.connect(unpause_a)
	pause()

func unpause_a():
	var btn = Globals.buttons_container.lure_door_buttons.get_child(1)
	btn.on_pressed.disconnect(unpause_a)
	unpause(null)

func all_lights_flicker(flicker_rate):
	%Environment.all_lights_flicker(flicker_rate)


func all_lights_flicker_hard():
	%Environment.all_lights_flicker(1.09)

func all_lights_flicker_medium():
	%Environment.all_lights_flicker(1.04)
	
func all_lights_flicker_none():
	%Environment.all_lights_flicker(0.5)
	
	
