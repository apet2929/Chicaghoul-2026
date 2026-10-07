extends Node

signal camera_change(new_camera: XRCamera3D)

var subtitle_inst: Subtitle = null
var camera: XRCamera3D = null
func set_camera(camera: XRCamera3D):
	self.camera = camera
	camera_change.emit(camera)
