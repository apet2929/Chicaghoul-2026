extends Node

signal camera_change(new_camera: XRCamera3D)
signal button_pressed(button)
signal on_teleport(target: TeleportTarget)

var main_monitor_ui_inst: ShipMonitorUI = null
var monitors: Array[ShipMonitorUI] = []
var subtitle_inst: Subtitle = null
var camera: XRCamera3D = null
var teleporting = false # Poor man's mutex
func set_camera(camera: XRCamera3D):
	self.camera = camera
	camera_change.emit(camera)
	
func teleport_to(target: TeleportTarget):
	on_teleport.emit(target)
