extends Node

signal camera_change(new_camera: XRCamera3D)
signal button_pressed(button)
signal on_teleport(target: TeleportTarget)
signal recording_finished(recording: AudioStreamWAV)
signal passphrase_correct(buttons)
signal passphrase_incorrect(buttons)
signal passphrase_updated(name)
signal teleport_middle # used to time when to move player during teleport, see game.gd
signal open_close_cargo_hold_door(is_open: bool)
signal open_close_escape_pod_door(is_open: bool)
signal open_close_cockpit_door(is_open: bool)
signal submit_button_pressed

var main_monitor_ui_inst: ShipMonitorUI = null
var monitors: Array[ShipMonitorUI] = []
var subtitle_inst: Subtitle = null
var camera: XRCamera3D = null
var teleporting = false # Poor man's mutex
var passcode_states = {
	
}
var buttons_container: ButtonsContainer = null

@onready var button_down_audio = load("res://assets/me/audio/button-down.mp3")
@onready var button_up_audio = load("res://assets/me/audio/button-down.mp3")

func set_camera(camera: XRCamera3D):
	self.camera = camera
	camera_change.emit(camera)
	
func teleport_to(target: TeleportTarget):
	on_teleport.emit(target)
