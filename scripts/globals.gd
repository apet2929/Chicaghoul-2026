extends Node

signal camera_change(new_camera: XRCamera3D)
signal button_pressed(button)
signal recording_finished(recording: AudioStreamWAV)
signal passphrase_correct(buttons)
signal passphrase_incorrect(buttons)
signal passphrase_updated(name)
signal open_close_cargo_hold_door(is_open: bool)
signal open_close_escape_pod_door(is_open: bool)
signal open_close_cockpit_door(is_open: bool)
signal open_close_closet_door(is_open: bool)
signal open_close_engine_room_door(is_open: bool)
signal submit_button_pressed
signal game_over
# TODO: Implement lures
signal lure_played(location: Node3D) # see alien.gd locations
signal alien_moved(loc_idx)

var checkpoint = 0
var checkpoint_cur_dialogue_line = 0
var has_intercom = false # TODO: linked with checkpoint?
var main_monitor_ui_inst: ShipMonitorUI = null
var monitors: Array[ShipMonitorUI] = []
var subtitle_inst: Subtitle = null
var camera: XRCamera3D = null
#var teleporting = false # Poor man's mutex
var passcode_states = {}
var buttons_container: ButtonsContainer = null
var checkpoint_alien_location = -1
var lure_audio: AudioStream
var door_lock_buttons_container: DoorLockContainer = null
var doors_container: DoorsContainer = null
var epilepsy_protection = false
var ambience_manager: AmbienceManager

@onready var button_down_audio = load("res://assets/me/audio/button-down.mp3")
@onready var button_up_audio = load("res://assets/me/audio/button-down.mp3")

func set_camera(camera: XRCamera3D):
	self.camera = camera
	camera_change.emit(camera)

func restart_from_checkpoint():
	# Reset anything that would be set during game scene initialization
	passcode_states = {}
	has_intercom = false
	main_monitor_ui_inst =null
	monitors = []
	subtitle_inst =null
	camera = null
	passcode_states = {}
	buttons_container = null
