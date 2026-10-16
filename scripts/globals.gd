extends Node

signal camera_change(new_camera: XRCamera3D)
signal button_pressed(button)
signal on_teleport(target: TeleportTarget)
signal recording_finished(recording: AudioStreamWAV)
signal passphrase_correct()
signal passphrase_incorrect()
signal teleport_middle # used to time when to move player during teleport, see game.gd

var main_monitor_ui_inst: ShipMonitorUI = null
var monitors: Array[ShipMonitorUI] = []
var subtitle_inst: Subtitle = null
var camera: XRCamera3D = null
var teleporting = false # Poor man's mutex

@onready var button_down_audio = load("res://assets/me/audio/button-down.mp3")
@onready var button_up_audio = load("res://assets/me/audio/button-down.mp3")

func set_camera(camera: XRCamera3D):
	self.camera = camera
	camera_change.emit(camera)
	
func teleport_to(target: TeleportTarget):
	on_teleport.emit(target)
