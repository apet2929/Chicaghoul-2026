@tool
extends Node3D

#var screen_inst: ShipMonitorUI
@export var ui_view = false

func _ready() -> void:
	#self.call_deferred("set_ui_screen_inst")
	$CameraView.visible = true
	

#func set_ui_screen_inst():
	#var screen_viewport = $"UIView"
	#screen_inst = screen_viewport.find_child("MonitorUI", true, true)
	
